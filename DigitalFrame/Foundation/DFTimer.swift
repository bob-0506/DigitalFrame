//
//  DFTimer.swift
//  DigitalFrame
//
//  Created by bob on 12/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import Foundation

class DFTimer {
    private struct Constant {
        static let minInterval = TimeInterval(1)
        static let maxInterval = TimeInterval(10)
        static let defaultInterval = TimeInterval(3)
    }
    
    static let shared = DFTimer()
    
    private var timer = Timer()
    private var onTimeHandler: (() -> Void)?
    
    private var lastFiredDate = Date()
    
    enum State {
        case running
        case pending
        case stopped
    }
    
    private(set) var state = State.stopped

    init() {
        self.interval = Constant.defaultInterval
    }
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    var interval: TimeInterval {
        didSet {
            switch interval {
            case ..<Constant.minInterval:
                interval = Constant.minInterval
                
            case Constant.maxInterval...:
                interval = Constant.maxInterval
                
            default:
                break
            }
            
            guard oldValue != interval else {
                return
            }
            
            // interval이 변경되는 시점에 새로 세팅
            lastFiredDate = Date()
        }
    }
    
    func onTime(onTimeHandler: (() -> Void)?) {
        self.onTimeHandler = onTimeHandler
    }
    
    func start() {
        lastFiredDate = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: onTime)
        state = .running
    }
    
    func stop() {
        timer.invalidate()
        state = .stopped
    }
    
    func wait() {
        timer.invalidate()
        state = .pending
    }
    
    private func onTime(_ timer: Timer) {
        guard -lastFiredDate.timeIntervalSinceNow > interval else {
            return
        }
        
        lastFiredDate = Date()
        self.onTimeHandler?()
    }
}
