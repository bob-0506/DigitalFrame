//
//  FrameImageView.swift
//  DigitalFrame
//
//  Created by bob on 13/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import UIKit

class FrameImageView: UIImageView {

    weak var contentView: UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    override var image: UIImage? {
        didSet {
            contentView?.image = image
        }
    }
    
    private func initialize() {
        self.contentMode = .scaleAspectFill
        
        // add blur effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(effectView)
        
        effectView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        effectView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        effectView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        effectView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // add content view
        let newView = UIImageView(frame: .zero)
        newView.contentMode = .scaleAspectFit
        newView.backgroundColor = .clear
        newView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newView)
        
        if #available(iOS 11.0, *) {
            newView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
            newView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
            newView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
            newView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
        } else {
            newView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            newView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            newView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            newView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        self.contentView = newView
    }

}
