//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Baratta, Dominic on 10/26/16.
//  Copyright © 2016 Dominic Baratta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapToRecordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordButtonPress(_ sender: UIButton) {
        tapToRecordLabel.text = "Recording"
    }

}

