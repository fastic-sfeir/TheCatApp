//
//  CATHTTPClient+AccountAPI.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 02/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import Alamofire

extension CATHTTPClient {
    
    //MARK: Private funcs for instance
    private func requestAccount(route:String, parameters:[String:Any]? = nil) -> URLRequest? {
        if var request = CATHTTPClient.urlBuilder(route: route, parameters: parameters) {
            request.addValue(self.apiKey, forHTTPHeaderField: CATHTTPClient.HTTP_HEADER_X_AUTH_TOKEN)
            request.addValue(CATHTTPClient.HTTP_HEADER_CONTENT_TYPE_VALUE_JSON, forHTTPHeaderField: CATHTTPClient.HTTP_HEADER_CONTENT_TYPE)
            return request
        }
        return nil
    }
    
    //MARK: Instance funcs - Cat API Account mode
    func set(apiKey key:String, accountId account:String) {
        self.apiKey = key
        self.accountId = account
    }

    // List all favorites
    func favorites(completion:@escaping (([CATJSONFavourite]?, Error?) -> ())) {
        let route = String(format:"%@%@", CATHTTPClient.HTTP_BASE_API_VERSION, CATHTTPClient.HTTP_ROUTE_FAVORITE)
        if let request = requestAccount(route: route) {
            Alamofire
                .request(request)
                .responseJSON { (response) in
                    
                    if let resp = response.response, resp.statusCode == 401 {
                        completion(nil, CATHTTPErrorHelper.badAccountInformation())
                    } else {
                        if let data = response.data, let objects = try? JSONDecoder().decode(Array<CATJSONFavourite>.self, from: data) {
                            completion(objects, nil)
                        } else {
                            if let resp = response.response, resp.statusCode == 200 {
                                completion(nil, nil)
                            } else {
                                completion(nil, CATHTTPErrorHelper.malformedJSONError())
                            }
                            
                        }
                    }
                }
        } else {
            completion(nil, CATHTTPErrorHelper.noAccountInformation())
        }
        
        
    }
    
    //
    func fav(imageId:String, completion:@escaping ((Error?) -> ())) {
        let route = String(format:"%@%@", CATHTTPClient.HTTP_BASE_API_VERSION, CATHTTPClient.HTTP_ROUTE_FAVORITE)
        if var request = requestAccount(route: route) {
            let body  = [ CATHTTPClient.POST_PARAM_IMAGE_ID : imageId, CATHTTPClient.POST_PARAM_SUB_ID : self.accountId]
            if let json = try? JSONEncoder().encode(body) {
                request.httpMethod = HTTPMethod.post.rawValue
                request.httpBody = json
                Alamofire
                    .request(request)
                    .responseJSON { (resp) in
                        if let code = resp.response?.statusCode, code == 200 {
                            completion(nil)
                        } else {
                            if let err = resp.error {
                                completion(err)
                            } else {
                                completion(CATHTTPErrorHelper.badAccountInformation())
                            }
                        }
                    }
            } else {
                completion(CATHTTPErrorHelper.malformedJSONError())
            }
        } else {
            completion(CATHTTPErrorHelper.undownloadableURL())
        }
    }
    
    func unfav(imageId:String, completion:@escaping ((Error?) -> ())) {
        let route = String(format:"%@%@/%@", CATHTTPClient.HTTP_BASE_API_VERSION, CATHTTPClient.HTTP_ROUTE_FAVORITE, imageId)
        if var request = requestAccount(route: route) {
            request.httpMethod = HTTPMethod.delete.rawValue
            Alamofire
                .request(request)
                .responseJSON { (resp) in
                    if let code = resp.response?.statusCode, code == 200 {
                        completion(nil)
                    } else {
                        if let err = resp.error {
                            completion(err)
                        } else {
                            completion(CATHTTPErrorHelper.badAccountInformation())
                        }
                    }
            }
        } else {
            completion(CATHTTPErrorHelper.undownloadableURL())
        }
    }
    
    func votes() {
        
    }
    
    func vote() {
        
    }
    
    func unvote() {
        
    }
}
