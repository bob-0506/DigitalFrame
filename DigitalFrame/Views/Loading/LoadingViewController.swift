//
//  LoadingViewController.swift
//  DigitalFrame
//
//  Created by bob on 08/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import UIKit

protocol LoadingViewControllerDelegate: class {
    func loadingViewController(_ viewController: LoadingViewController)
}

class LoadingViewController: UIViewController {
    
    weak var delegate: LoadingViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DFImageManager.shared.prepare { [weak self] (succeeded) in
            guard let _ = self else {
                return
            }
            
            self?.delegate?.loadingViewController(self!)
        }
    }
}
