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
            .duration(0.4),
            .transitionA(.fromBottom),
            .transitionB(.toBottom),
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
            .hideStatusBar(true),
            .position(.top),
            .transitionA(.fromTop),
            .transitionB(.toTop)
        ]
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()
    
    lazy var popupViewNotifier: AANotifier = {
        
        let notifierView = UIView.fromNib(nibName: "PopupView")!
        let options: [AANotifierOptions] = [
            .position(.middle),
            .preferedHeight(250),
            .margins(H: 20, V: nil),
            .transitionA(.fromTop),
            .transitionB(.toBottom)
        ]
        let button = notifierView.viewWithTag(100) as! UIButton
        button.addTarget(self, action: #selector(hidePopupView), for: .touchUpInside)
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()
    
    lazy var infoViewNotifier: AANotifier = {
        
        let notifierView = UIView.fromNib(nibName: "InfoView")!
        let options: [AANotifierOptions] = [
            .position(.top),
            .preferedHeight(80),
            .transitionA(.fromTop),
            .transitionB(.toTop)
        ]
        let notifier = AANotifier(notifierView, withOptions: options)
        return notifier
    }()

    lazy var snackBarViewNotifier: AANotifier = {
        
        let notifierView = LikeView()
        let options: [AANotifierOptions] = [
            .position(.bottom),
            .preferedHeight(60),
            .hideOnTap(false),
            .transitionA(.fromBottom),
            .transitionB(.toLeft)
        ]
        let notifier = AANotifier(notifierView, withOptions: options)
        notifierView.notifer = notifier
        return notifier
    }()
    
    lazy var notifiers: [AANotifier] = {
        let notifiers: [AANotifier] = [self.toastViewNotifier,
                                       self.statusViewNotifier,
                                       self.popupViewNotifier,
                                       self.infoViewNotifier,
                                       self.snackBarViewNotifier]
        return notifiers
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
    
    @IBAction func addNotifiersAction(_ sender: Any) {
        notifiers.forEach({$0.addView()})
    }
    
    @IBAction func removeNotifiersAction(_ sender: Any) {
        notifiers.forEach({$0.removeView()})
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
        notifier.animateNotifer(true, deadline: 2, didTapped: {
            notifier.hide()
        })
    }
    
    @IBAction func statusViewAction(_ sender: Any) {
        statusViewNotifier.show()
    }

    @IBAction func popupViewAction(_ sender: Any) {
        popupViewNotifier.show()
    }
    
}






