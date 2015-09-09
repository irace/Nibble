//
//  Response.swift
//  Nibble
//
//  Created by Bryan Irace on 9/8/15.
//  Copyright (c) 2015 Bryan Irace. All rights reserved.
//

import Foundation
import Alexander

public struct Response {
    public let data: [String: JSON]
    public let success: Bool
    
    static func decode(JSON: Alexander.JSON) -> Response? {
        if let data = JSON["data"]?.dictionary, success = JSON["success"]?.int {
            return Response(data: data, success: success == 0 ? false : true)
        }
        
        return nil
    }
}
