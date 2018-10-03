//
//  CATDownloadOperation.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
/// Asynchronous Operation subclass for downloading

class CATDownloadOperation : CATAsynchronousOperation {
    let task: URLSessionTask
    
    init(session: URLSession, url: URL) {
        task = session.downloadTask(with: url)
        super.init()
    }
    
    override func cancel() {
        task.cancel()
        super.cancel()
    }
    
    override func main() {
        task.resume()
    }
}

// MARK: NSURLSessionDownloadDelegate methods

extension CATDownloadOperation: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let manager = FileManager.default
//            if let destinationURL = LVWDataManager.pathForContent()?.appendingPathComponent(downloadTask.originalRequest!.url!.lastPathComponent), let url = downloadTask.originalRequest?.url {
//                try? manager.removeItem(at: destinationURL)
//                try manager.moveItem(at: location, to: destinationURL)
//                LVWDataManager.shared.URLManager().append(url: url.absoluteString, localUrl: url.lastPathComponent)
//                
//            }
        } catch {
            print(error)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        //        print("\(downloadTask.originalRequest!.url!.absoluteString) \(progress)")
    }
}

// MARK: URLSessionTaskDelegate methods

extension CATDownloadOperation: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)  {
        defer { finish() }
        
        if let error = error {
            print(error)
            return
        }
        
        // do whatever you want upon success
    }
    
}
