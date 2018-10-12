//
//  CATHTTPClient+OpenAPI.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import Alamofire
import FLAnimatedImage

extension CATHTTPClient {
    static func browse(types:[CATHTTPClientOptionMimeType]? = nil, completion:@escaping (([CATJSONImage]?, Error?) -> ())) {
        let route = String(format:"%@%@%@", HTTP_BASE_API_VERSION, HTTP_ROUTE_BASE_IMAGE, HTTP_ROUTE_BROWSE)
        let parameters = CATHTTPClient.parameters(limit: HTTP_DEFAULT_LIMIT, types: types)
        
        if let url = urlBuilder(route: route, parameters: parameters) {
            Alamofire
                .request(url)
                .responseJSON { (response) in
                    if let err = response.error {
                        completion(nil, err)
                    } else {
                        if let d = response.data, let decoded = try? JSONDecoder().decode(Array<CATJSONImage>.self, from: d) {
                            completion(decoded, nil)
                        } else {
                            completion(nil, CATHTTPErrorHelper.malformedJSONError())
                        }
                    }
                }
        } else {
            completion(nil, CATHTTPErrorHelper.malformedURLError())
        }
    }
    
    static func image(url:String, completion:@escaping ((Any?, Error?) -> ())) {
        if let urlObject = URL(string:url) {
            Alamofire
                .request(urlObject)
                .response { (resp) in
                    if let d = resp.data {
                        if let mimeType = resp.response?.allHeaderFields[HTTP_HEADER_CONTENT_TYPE] as? String, mimeType == MIME_TYPE_ANIMATED_IMAGE {
                            completion(FLAnimatedImage(animatedGIFData: d), nil)
                        } else {
                            completion(UIImage(data: d), nil)
                        }
                    } else {
                        let err = resp.error ?? CATHTTPErrorHelper.undownloadableURL()
                        completion(nil, err)
                    }
                }
        } else {
            completion(nil, CATHTTPErrorHelper.malformedURLError())
        }
    }
    
    static func image(byId:String, completion:@escaping ((Any?, Error?) -> ())) {
        let route =  String(format:"%@%@/%@", HTTP_BASE_API_VERSION, HTTP_ROUTE_BASE_IMAGE, byId)
        if let url = urlBuilder(route: route, parameters: nil) {
            Alamofire
                .request(url)
                .responseJSON { (resp) in
                    if let json = resp.data,  let image = try? JSONDecoder().decode(CATJSONImage.self, from: json) {
                        CATHTTPClient.image(url: image.url, completion: completion)
                    } else {
                        if let err = resp.error {
                            completion(nil, err)
                        } else {
                            completion(nil, CATHTTPErrorHelper.malformedJSONError())
                        }
                    }
                }
        } else {
            completion(nil, CATHTTPErrorHelper.malformedURLError())
        }
    }
}
