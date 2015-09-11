//
//  BFF.swift
//  Nibble
//
//  Created by Bryan Irace on 9/9/15.
//  Copyright (c) 2015 Bryan Irace. All rights reserved.
//

import Foundation

struct BFF {
    let version: String
    let background: [Float] // TODO: Also should support `[[Float]]` but Swift doesn’t yet let you specify that `[Float]` conforms to a protocl
    let objects: [String]
    
    struct Object {
        enum Type {
            case Paragraph, Text, Link, Image, Graphic, GIF, Video, Music // TODO: Use associated values
        }
        
        struct Frame {
            let x: Float
            let y: Float
            let width: Float
            let height: Float
        }
        
        let type: Type
        let frame: Frame
        let name: String
        let transform: [[Float]] // TODO: Can have a more specific type
        let opacity: Float
        let effects: [String] // TODO: Can have a more specific type
    }
    
    struct Paragraph: Object {
        enum Style {
            case Sans, Serif
        }

        enum Alignment {
            case Left, Center, Right
        }
        
        enum AttributeType {
            case Bold, Italic, BoldItalic
        }
        
        let text: String
        let color: [Float] // TODO: Can have a more specific type
        let style: Style
        let size: Float
        let alignment: Alignment
        let attributes: [[String: String]] // TODO: Can have a more specific type
    }
}
