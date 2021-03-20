//
//  ViewController.swift
//  FacialExpressions
//
//  Created by Gualtiero Frigerio on 13/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FaceTrackerAR.isAvailable() {
            startButton.isEnabled = true
        }
        else {
            startButton.isEnabled = false
        }
    }

    @IBAction func startButtonTap(_ sender: Any) {
        
    }
    
}

