//
//  ViewController.swift
//  EggTimer
//
//  Created by Kubra Bozdogan on 7/10/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var secondsRemaining = 60
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundImage.alpha = 0.5
        progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        let chosenHardness = eggTimes[hardness]!
        
//        totalTime = chosenHardness * secondsRemaining
//        Total time equaled the chosenHardness to show you more shortly time.
        totalTime = chosenHardness
        
        progressBar.progress = 0.0
        secondsPassed = 0
//        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            let urlPrograss = Bundle.main.url(forResource: "chickensClucking", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: urlPrograss!)
            
            player!.play()
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "roosterCrowing", withExtension: "wav")
            
            player = try! AVAudioPlayer(contentsOf: url!)
            
            player!.play()
            
        }
    }
    
}

