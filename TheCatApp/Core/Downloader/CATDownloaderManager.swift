//
//  CATDownloaderManager.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
/// Manager of asynchronous download `Operation` objects

class CATDownloaderManager: NSObject {
    
    /// Dictionary of operations, keyed by the `taskIdentifier` of the `URLSessionTask`
//    weak var delegate : LVWDownloaderProtocol?
    fileprivate var operations = [Int: CATDownloadOperation]()
    
    /// Serial OperationQueue for downloads
    
    private let queue: OperationQueue = {
        let _queue = OperationQueue()
        _queue.name = "download"
        _queue.maxConcurrentOperationCount = 3    // I'd usually use values like 3 or 4 for performance reasons, but OP asked about downloading one at a time
        
        return _queue
    }()
    
    /// Delegate-based `URLSession` for LVWDownloadManager
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    /// Add download
    ///
    /// - parameter URL:  The URL of the file to be downloaded
    ///
    /// - returns:        The DownloadOperation of the operation that was queued
    
    @discardableResult
    func queueDownload(_ url: URL) -> CATDownloadOperation {
        let operation = CATDownloadOperation(session: session, url: url)
        operations[operation.task.taskIdentifier] = operation
        queue.addOperation(operation)
        return operation
    }
    
    /// Cancel all queued operations
    
    func cancelAll() {
        queue.cancelAllOperations()
    }
    
}

// MARK: URLSessionDownloadDelegate methods

extension CATDownloaderManager: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        operations[downloadTask.taskIdentifier]?.urlSession(session, downloadTask: downloadTask, didFinishDownloadingTo: location)
//        if let dlgt = delegate, let comp = dlgt.progressing {
//            comp(0)
//        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        operations[downloadTask.taskIdentifier]?.urlSession(session, downloadTask: downloadTask, didWriteData: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
    }
}

// MARK: URLSessionTaskDelegate methods

extension CATDownloaderManager: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)  {
        let key = task.taskIdentifier
        operations[key]?.urlSession(session, task: task, didCompleteWithError: error)
        operations.removeValue(forKey: key)
//        if let dlgt = delegate, let comp = dlgt.error, let url = task.currentRequest?.url, let err = error {
//            comp(url.absoluteString, err)
//        }
    }
    
}
