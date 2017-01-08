//
//  ViewController.swift
//  Game Of Life
//
//  Created by Duy Anh on 1/8/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: GameDataSource!
    var gameViewDelegate: GameViewDelegate!
    
    @IBOutlet weak var widthText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var probText: UITextField!
    @IBOutlet weak var intervalText: UITextField!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dataSource = GameDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        
        self.gameViewDelegate = GameViewDelegate(controller: self)
        collectionView.delegate = gameViewDelegate
        
        configButtons()
    }
    
    func configButtons() {
        playButton.isEnabled = false
        pauseButton.isEnabled = false
        
        generateButton.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)
    }

    func generateTapped() {
        guard let width = Int(widthText.text!), let height = Int(heightText.text!), let prob = Float(probText.text!) else { return }
        guard width > 0, height > 0, prob >= 0, prob <= 1 else { return }
        
        destroyTimer()
        
        dataSource.set(width: width, height: height, probability: prob)
        playButton.isEnabled = true
        
        view.endEditing(true)
    }
    
    func playTapped() {
        guard let interval = Double(intervalText.text!) else { return }
        
        generateTimer(interval: interval)
        pauseButton.isEnabled = true
        playButton.isEnabled = false
        
        view.endEditing(true)
    }
    
    func pauseTapped() {
        destroyTimer()
        
        pauseButton.isEnabled = false
        playButton.isEnabled = true
        
        view.endEditing(true)
    }
    
    func destroyTimer() {
        if self.timer != nil { timer.invalidate(); timer = nil }
    }
    
    func generateTimer(interval: Double) {
        destroyTimer()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [unowned self]
            _ in
            self.dataSource.play()
        }
    }
}

