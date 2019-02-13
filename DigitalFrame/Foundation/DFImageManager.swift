//
//  DFImageManager.swift
//  DigitalFrame
//
//  Created by bob on 13/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import Foundation

protocol DFImageManagerDelegate: AnyObject {
    func imageManager(_ imageManager: DFImageManager, arrivedImageFor entry: DFEntry)
}

class DFImageManager {
    private struct Constant {
        static let minStocks = 5
    }
    
    static let shared = DFImageManager()
    
    weak var delegate: DFImageManagerDelegate?
    
    private var entries: [DFEntry]?
    
    var current: DFEntry? {
        return self.entries?.first
    }
    var next: DFEntry? {
        guard self.entries?.count ?? 0 >= 2 else {
            return nil
        }
        
        return self.entries?[1]
    }
    
    func prepare(_ completion: @escaping (Bool) -> Void) {
        loadFeeds { (entries) in
            guard let _ = entries else {
                completion(false)
                return
            }
            
            self.entries = entries
            
            self.loadImage(for: entries?.first) {
                completion(true)
            }
            
            guard entries?.count ?? 0 >= 2 else {
                return
            }

            self.loadImage(for: entries?[1], completion: nil)
        }
    }
    
    func moveNext() -> Bool {
        guard self.entries?.count ?? 0 >= 2 else {
            return false
        }
        
        entries?.removeFirst()
        
        if self.entries?.count ?? Constant.minStocks < Constant.minStocks {
            loadFeeds { [weak self] (entries: [DFEntry]?) in
                guard let newEntries = entries else {
                    return
                }
                self?.entries?.append(contentsOf: newEntries)
            }
        }
        
        guard self.entries?.count ?? 0 >= 2 else {
            return true
        }
        
        self.loadImage(for: entries?[1]) {}
        
        return true
    }
    
    private func loadFeeds(_ completion: @escaping ([DFEntry]?) -> Void) {
        UBNetwork.request(Server.url(.feed), parameters: nil) { (response: UBNetwork.Response<DFFeed>) in
            completion(response.data?.entries)
        }
    }
    
    private func loadImage(for entry: DFEntry?, completion: (() -> Void)?) {
        guard let urlString = entry?.link?.enclosure else {
            completion?()
            return
        }
        
        UBNetwork.downloadImage(urlString) { [weak entry](image) in
            guard let weakEntry = entry else {
                completion?()
                return
            }
            
            weakEntry.image = image
            completion?()
            
            self.delegate?.imageManager(self, arrivedImageFor: weakEntry)
        }
    }
}
