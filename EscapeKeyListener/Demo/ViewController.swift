//
//  ViewController.swift
//  Demo
//
//  Created by peng hao on 2018/5/15.
//  Copyright © 2018年 peng hao. All rights reserved.
//

import UIKit
import EscapeKeyListener

class ViewController: UIViewController {
    let keyboardEventManager: KeyboardEventManager = KeyboardEventManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //listen esc
        keyboardEventManager.addObserver(0x29) { (pressedDown) in
            print("Esc has been pressed. isPressedDown =", pressedDown ? "true" : "false");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

