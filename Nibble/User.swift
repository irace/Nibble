//
//  User.swift
//  Nibble
//
//  Created by Bryan Irace on 9/8/15.
//  Copyright (c) 2015 Bryan Irace. All rights reserved.
//

import Foundation
import Alexander

public struct User: JSONDecodable {
    let created: Int
    let timeZone: String
    let id: String
    
    public static func decode(JSON: Alexander.JSON) -> User? {
        if let created = JSON["created"]?.int,
            let timeZone = JSON["timeZone"]?.string,
            let id = JSON["id"]?.string {
                return User(created: created, timeZone: timeZone, id: id)
        }
        
        return nil
    }
}
