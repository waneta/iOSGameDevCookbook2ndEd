//
//  ViewController.swift
//  TouchRegion
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func tapped(_ tap: UITapGestureRecognizer) {
        if tap.state == UIGestureRecognizerState.ended {
            print("Tapped!")
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

