//
//  ControlViewController.swift
//  DigitalFrame
//
//  Created by bob on 13/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton?
    @IBOutlet weak var intervalSlider: UISlider?
    
    private var dismissTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intervalSlider?.value = Float(DFTimer.shared.interval)
        
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resetTimer()
    }
    
    @IBAction func onIntervalChanged(_ sender: UISlider) {
        DFTimer.shared.interval = TimeInterval(sender.value)
        
        resetTimer()
    }
    
    @IBAction func onControlButton(_ sender: UIButton) {
        switch DFTimer.shared.state {
        case .stopped:
            DFTimer.shared.start()
        default:
            DFTimer.shared.stop()
        }
        
        updateUI()
        resetTimer()
    }
    
    private func updateUI() {
        switch DFTimer.shared.state {
        case .stopped:
            actionButton?.setImage(#imageLiteral(resourceName: "ic_play"), for: .normal)
        default:
            actionButton?.setImage(#imageLiteral(resourceName:"ic_pause"), for: .normal)
        }
    }
    
    private func resetTimer() {
        dismissTimer?.invalidate()
        dismissTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in
            self.dismiss(animated: true)
        })
    }
}
