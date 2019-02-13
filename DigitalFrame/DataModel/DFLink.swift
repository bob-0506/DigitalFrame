//
//  DFLink.swift
//  DigitalFrame
//
//  Created by bob on 12/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import XMLMapper

class DFLink: XMLMappable {
    
    enum LinkType: String {
        case alternate = "alternate"
        case enclosure = "enclosure"
    }
    
    var nodeName: String!
    
    var type: String?
    var rel: String?
    var href: String?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        type <- map.attributes["type"]
        rel <- map.attributes["rel"]
        href <- map.attributes["href"]
    }
}

extension Array where Element == DFLink {
    var enclosure: String? {
        return self.filter({ $0.rel?.lowercased() == "enclosure"}).first?.href
    }
}
