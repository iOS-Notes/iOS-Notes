//
//  ViewController.swift
//  Project 01 - SimpleStopWatch
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var playBtn: UIButton!
    var pauseBtn: UIButton!
    var timerLabel: UILabel!
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc func playButtonDidTouch(sender: AnyObject) {
        if(isPlaying) {
            return
        }
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @objc func pauseButtonDidTouch(sender: AnyObject) {
        
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        timer.invalidate()
        isPlaying = false
    }
    
    @objc func updateTimer() {
        counter = counter + 0.1
        timerLabel.text = String(format: "%.1f", counter)
    }
    
}

extension ViewController {
    
    func setupUI() {
        
        timerLabel = UILabel.init()
        timerLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        timerLabel.backgroundColor = UIColor.black
        timerLabel.textColor = UIColor.white
        timerLabel.text = "0"
        timerLabel.font = UIFont.systemFont(ofSize: 100.0)
        timerLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(timerLabel)
        
        playBtn = UIButton(type: .custom)
        playBtn.frame = CGRect(x: 0, y: timerLabel.frame.maxY, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height - 200)
        playBtn.backgroundColor = UIColor.blue
        playBtn.setImage(UIImage.init(named: "play"), for: .normal)
        playBtn.addTarget(self, action: #selector(playButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(playBtn)
        
        pauseBtn = UIButton(type: .custom)
        pauseBtn.frame = CGRect(x: playBtn.frame.maxX, y: timerLabel.frame.maxY, width: playBtn.bounds.width, height: playBtn.bounds.height)
        pauseBtn.backgroundColor = UIColor.green
        pauseBtn.setImage(UIImage.init(named: "pause"), for: .normal)
        pauseBtn.addTarget(self, action: #selector(pauseButtonDidTouch), for: .touchUpInside)
        self.view.addSubview(pauseBtn)
    }
}
