//
//  ViewController.swift
//  CountAnimation
//
//  Created by De La Cruz, Eduardo on 26/11/2018.
//  Copyright © 2018 De La Cruz, Eduardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var displayLink = CADisplayLink()
    var displayLinkForString = CADisplayLink()
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var stringCountingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
        
        // Create my CADisplaylink
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLinkForString = CADisplayLink(target: self, selector: #selector(handleUpdateForString))
        displayLink.add(to: .main, forMode: .default)
        displayLinkForString.add(to: .main, forMode: .default)
        }
    
    var startValue: Double = 0
    var startValueForString = 0
    let endValue: Double = 1000
    let animationDuration: Double = 6.5
    var startText = ""
    let endText: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    
    let animationStartDate = Date()
    
    @objc func handleUpdateForString() {
        let endTextValue = endText.count - 1
        let index = endText.index(endText.startIndex, offsetBy: startValueForString)
        self.stringCountingLabel.text = "\(startText)"
        startText += String(endText[index])
        startValueForString += 1
        
        if startValueForString > endTextValue {
            displayLinkForString.invalidate()
            self.stringCountingLabel.text = "\(startText)"
        }
    }
    
    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        let percentage = elapsedTime / animationDuration
        let value = startValue + percentage * (endValue - startValue)
        self.countingLabel.text = "\(value)"
        
        if elapsedTime >= animationDuration {
            displayLink.invalidate()
            self.countingLabel.text = "\(endValue)"
        }
    }
}
