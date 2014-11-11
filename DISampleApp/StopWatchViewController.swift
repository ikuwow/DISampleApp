//
//  ViewController.swift
//  DISampleApp
//
//  Created by 出川 幾夫 on 11/11/14.
//  Copyright (c) 2014 Ikuo Degawa. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var startTime: NSTimeInterval? // 実態はDouble型
    var timer: NSTimer?
    var elapsedTime: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonEnabled(true, stop: false, reset: false)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButtonEnabled(start: Bool, stop: Bool, reset: Bool) {
        self.startButton.enabled = start
        self.stopButton.enabled = stop
        self.resetButton.enabled = reset
    }
    
    func update() {
        
        if let t = self.startTime {
            let time: Double = NSDate.timeIntervalSinceReferenceDate() - t + self.elapsedTime
            let sec: Int = Int(time)
            let msec: Int = Int((time - Double(sec))*100.0)
            self.timerLabel.text = NSString(format: "%02d:%02d:%02d", sec/60, sec%60, msec)
            
        }
    }

    @IBAction func startTimer(sender: AnyObject) {
        println("Timer Start!")
        self.setButtonEnabled(false, stop: true, reset: false)
        self.startTime = NSDate.timeIntervalSinceReferenceDate() // 2001/1/1からのinterval
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    @IBAction func stopTimer(sender: AnyObject) {
        self.setButtonEnabled(true, stop: false, reset: true)
        if let t = self.startTime {
            self.elapsedTime += NSDate.timeIntervalSinceReferenceDate() - t
        }
        self.timer?.invalidate()
        self.timer = nil
    }
    @IBAction func resetTimer(sender: AnyObject) {
        self.setButtonEnabled(true, stop: false, reset: false)
        self.startTime = nil
        self.timerLabel.text = "00:00:00"
    }

}

