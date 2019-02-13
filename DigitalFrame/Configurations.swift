//
//  Configurations.swift
//  DigitalFrame
//
//  Created by bob on 12/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import Foundation

struct Server {
    enum URLs: String {
        case feed = "https://api.flickr.com/services/feeds/photos_public.gne"
    }
    
    static func url(_ url: URLs) -> URL {
        return URL(string: url.rawValue)!
    }
}

