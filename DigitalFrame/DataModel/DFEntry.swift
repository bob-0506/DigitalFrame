//
//  DFEntry.swift
//  DigitalFrame
//
//  Created by bob on 12/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import XMLMapper

class DFEntry: XMLMappable {
    var nodeName: String!
    
    var title: String?
    var link: [DFLink]?
    
    var image: UIImage?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        title <- map["title"]
        link <- map["link"]
//        print(link ?? "")
    }
}


