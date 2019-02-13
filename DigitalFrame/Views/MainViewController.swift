//
//  MainViewController.swift
//  DigitalFrame
//
//  Created by bob on 12/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: ImageSwitchView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let timer = DFTimer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DFImageManager.shared.delegate = self
        
        timer.onTime(onTimeHandler: onTime)

        self.imageView.image = DFImageManager.shared.current?.image
        self.activityIndicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegue(withIdentifier: "control", sender: nil)
    }
    
    private func onTime() {
        guard DFImageManager.shared.moveNext() else {
            return
        }
        
        self.imageView.image = DFImageManager.shared.current?.image
        if let _ = DFImageManager.shared.current?.image {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        } else {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            timer.wait()
        }
    }
    
    @IBAction func exitToMain(_ segue: UIStoryboardSegue) {
    }
    
}

extension MainViewController: DFImageManagerDelegate {
    func imageManager(_ imageManager: DFImageManager, arrivedImageFor entry: DFEntry) {

        guard DFImageManager.shared.current?.link?.enclosure ?? "some text" == entry.link?.enclosure ?? "another text" else {
            return
        }
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        self.imageView.image = entry.image
        if timer.state == .pending {
            timer.start()
        }
    }
}
