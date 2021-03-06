//
//  CATHTTPClient.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 01/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import Alamofire
import FLAnimatedImage

class CATHTTPClient : NSObject {
    
    static let HTTP_HEADER_X_AUTH_TOKEN : String = "x-api-key"
    static let HTTP_HEADER_CONTENT_TYPE : String = "Content-Type"
    static let HTTP_HEADER_CONTENT_TYPE_VALUE_JSON : String = "application/json; charset=UTF-8"
    
    static let HTTP_DEFAULT_LIMIT : Int32 = 10
    static let HTTP_URL_REGISTER : String = "https://thecatapi.com/signup"
    static let HTTP_BASE_SCHEME : String = "https"
    static let HTTP_BASE_HOST : String = "api.thecatapi.com"
    static let HTTP_BASE_API_VERSION : String = "/v1/"
    static let HTTP_ROUTE_BASE_IMAGE : String = "images/"
    static let HTTP_ROUTE_BROWSE : String = "search/"
    static let HTTP_ROUTE_FAVORITE : String = "favourites/"
    
    static let QUERY_PARAM_LIMIT = "limit"
    static let QUERY_PARAM_MIMETYPE = "mime_types"
    
    static let MIME_TYPE_ANIMATED_IMAGE = "image/gif"
    
    static let POST_PARAM_IMAGE_ID = "image_id"
    static let POST_PARAM_SUB_ID = "sub_id"
    static let POST_PARAM_REMOTE_URL = "remote_url"
    
    var apiKey : String = ""
    var accountId : String = ""
    
    //MARK: Static func
    static func parameters(limit:Int32, types:[CATHTTPClientOptionMimeType]? = nil) -> [String : Any] {
        var p : [String : Any] = [QUERY_PARAM_LIMIT : limit]
        if let t = types {
            p[QUERY_PARAM_MIMETYPE] = t
        }
        return p
    }
    
    static func urlBuilder(route:String, parameters : [String: Any]?) -> URLRequest? {
        var comp = URLComponents()
        comp.scheme = HTTP_BASE_SCHEME
        comp.host = HTTP_BASE_HOST
        comp.path = route
        if let params = parameters {
            var queryItems = [URLQueryItem]()
            for p in params {
                if let arr = p.value as? Array<Any> {
                    queryItems.append(URLQueryItem(name: p.key, value: arr.concat(separator: ",")))
                } else {
                    queryItems.append(URLQueryItem(name: p.key, value: String(describing: p.value)))
                }
            }
            comp.queryItems = queryItems
        }
        if let u = try? comp.asURL() {
            return URLRequest(url: u, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        }
        return nil
    }
    
    
    
    
}
