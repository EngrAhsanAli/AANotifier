//
//  ViewController.swift
//  AANotifier
//
//  Created by Engr. Ahsan Ali on 02/11/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

import UIKit
import AANotifier


class ViewController: UIViewController {

    lazy var toastViewNotifier: AANotifier = {
        
        let notifierView = UIView.fromNib(nibName: "ToastView")!
        let options: [AANotifierOptions] = [
            .deadline(2.0),
            .transitionA(.fromBottom, 0.4),
            .transitionB(.toBottom, 5.0),
            .position(.bottom),
            .preferedHeight(50),
            .margins(H: 60, V: 40)
        ]
        
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()
    
    lazy var statusViewNotifier: AANotifier = {
        
        let notifierView = UIView.fromNib(nibName: "StatusView")!
        let options: [AANotifierOptions] = [
            .deadline(2.0),
            .preferedHeight(50),
            .margins(H: 0, V: 30),
            .position(.top),
            .transitionA(.fromTop, 0.8),
            .transitionB(.toTop, 0.8)
        ]
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()
    
     lazy var popupViewNotifier: AANotifier = {
        
        let notifierView = UIView.fromNib(nibName: "PopupView")!
        let options: [AANotifierOptions] = [
            .deadline(2.0),
            .position(.middle),
            .preferedHeight(250),
            .margins(H: 20, V: nil),
            .transitionA(.fromTop, 0.8),
            .transitionB(.toBottom, 0.8)
        ]
        let button = notifierView.viewWithTag(100) as! UIButton
        button.addTarget(self, action: #selector(hidePopupView), for: .touchUpInside)
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()
    
     lazy var infoViewNotifier: AANotifier = {
        
        let notifierView = UIView.fromNib(nibName: "InfoView")!
        let options: [AANotifierOptions] = [
            .deadline(2.0),
            .position(.top),
            .preferedHeight(80),
            .transitionA(.fromTop, 0.8),
            .transitionB(.toTop, 0.8)
        ]
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()

     lazy var snackBarViewNotifier: AANotifier = {
        
        let notifierView = LikeView()
        let options: [AANotifierOptions] = [
            .deadline(2.0),
            .position(.bottom),
            .preferedHeight(60),
            .hideOnTap,
            .transitionA(.fromBottom, 0.8),
            .transitionB(.toLeft, 0.8)
        ]
        let notifier = AANotifier(notifierView, withOptions: options)
        notifierView.notifer = notifier

        return notifier
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func hidePopupView() {
        popupViewNotifier.hide()
    }

    
}


extension ViewController {
    
    @IBAction func snackBarViewAction(_ sender: Any) {
        snackBarViewNotifier.show()
    }
    
    @IBAction func bannerViewAction(_ sender: Any) {
        infoViewNotifier.show()
    }
    @IBAction func toastViewAction(_ sender: Any) {
        
        let notifier = toastViewNotifier
        notifier.didTapped = {
            notifier.hide()
        }
        notifier.show()

    }
    
    @IBAction func statusViewAction(_ sender: Any) {
        statusViewNotifier.show()
    }

    @IBAction func popupViewAction(_ sender: Any) {
        popupViewNotifier.show()
    }
    
}






