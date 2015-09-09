//
//  ByteAPI.swift
//  Nibble
//
//  Created by Bryan Irace on 9/8/15.
//  Copyright (c) 2015 Bryan Irace. All rights reserved.
//

import Foundation
import Alexander

public typealias DefaultResponseCompletionHandler = Response -> Void
public typealias UserResponseCompletionHandler = (Response, User) -> Void

public class ByteAPI {
    private let session: NSURLSession
    
    // MARK: User state
    
    private var user: User?
    private var token: String?
    
    public init(session: NSURLSession) {
        self.session = session
    }
    
    // MARK: Authentication
    
    public func requestCode(phoneNumber: String, completionHandler: DefaultResponseCompletionHandler?) -> NSURLSessionDataTask {
        return POST("request-code", parameters: ["phone": phoneNumber]) { response in
            completionHandler?(response)
        }
    }
    
    public func auth(phoneNumber: String, code: String, completionHandler: UserResponseCompletionHandler?) -> NSURLSessionDataTask {
        return POST("auth", parameters: ["phone": phoneNumber, "code": code], completionHandler: { response in
            self.token = response.data["token"]?.string
            self.user = response.data["user"].flatMap(User.decode)
            
            completionHandler?(response, self.user!)
        })
    }
    
    // MARK: Private
    
    private func POST(path: String, parameters: [String: String], completionHandler: DefaultResponseCompletionHandler?) -> NSURLSessionDataTask {
        let baseURL: NSURL = NSURL(string: "https://api.byte.co/v1/")!
        
        let request = NSMutableURLRequest(URL: baseURL.URLByAppendingPathComponent(path))
        request.allHTTPHeaderFields = ["Content-Type": "application/json", "Accept": "application/json"]
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: nil)
        request.HTTPMethod = "POST"
        
        return session.dataTaskWithRequest(request, completionHandler: { (data, HTTPResponse, error) in
            if let response = JSON(data: data).flatMap(Response.decode) {
                completionHandler?(response)
            }
        })
    }
}
