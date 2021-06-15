//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var displayRemaining: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    var secondsRemaining = 1
    var totalTime = 1
    var timer = Timer()
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
  
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 1.0
        timer.invalidate()
        let hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(updateTimer), userInfo:nil, repeats: true)
        
    }
    @objc func updateTimer() {
        displayRemaining.text = String(secondsRemaining)
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            let percentDone = (Float(secondsRemaining) / Float(totalTime))
            progressBar.progress = percentDone
            print(percentDone)
            titleLabel.text = "Your eggs are cooking..."
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            progressBar.progress = 0.0
            playSound()
        }
    }
    
    
}
