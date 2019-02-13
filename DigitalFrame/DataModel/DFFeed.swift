//
//  DFFeed.swift
//  DigitalFrame
//
//  Created by bob on 12/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import XMLMapper

class DFFeed: XMLMappable {
    var nodeName: String!
    
    var title: String?
    var entries: [DFEntry]?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        title <- map["title"]
        entries <- map["entry"]
    }
}
