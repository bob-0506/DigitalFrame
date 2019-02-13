//
//  ImageSwitchView.swift
//  DigitalFrame
//
//  Created by bob on 13/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import UIKit

class ImageSwitchView: UIView {
    private struct Constant {
        static let switchAnimationLength = TimeInterval(0.8)
    }

    private weak var contentView: FrameImageView?
    private weak var backupView: FrameImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        let views: [FrameImageView] = [FrameImageView(frame: .zero), FrameImageView(frame: .zero)]
        for view in views {
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        contentView = views[0]
        backupView = views[1]
        
        backupView?.isHidden = true
    }
    
    var image: UIImage? {
        get {
            return contentView?.image
        }
        
        set {
            backupView?.image = contentView?.image
            contentView?.image = newValue
            
            contentView?.alpha = 0
            backupView?.alpha = 1
            backupView?.isHidden = false
            
            UIView.animate(withDuration: Constant.switchAnimationLength, animations: {
                self.contentView?.alpha = 1
                self.backupView?.alpha = 0
            }) { _ in
                self.backupView?.isHidden = true
            }
        }
    }
}
