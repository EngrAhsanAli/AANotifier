//
//  LikeView.swift
//  AANotifier
//
//  Created by Engr. Ahsan Ali on 15/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

import UIKit
import AANotifier

class LikeView: AANibView {
    
    var notifer: AANotifier?
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        button.setTitle("Dismiss", for: .normal)
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        notifer?.animateNotifer(false)
    }
    
}

