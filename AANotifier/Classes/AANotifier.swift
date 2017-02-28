//
//  AANotifier.swift
//  AANotifier
//
//  Created by Engr. Ahsan Ali on 11/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

import AAViewAnimator

/// MARK:- AANotifier
// AANotifier allows you to create UIView based fragments to be appear on screen at runtime
// It is designed to make custom elements in UIView even from xib based to animate on screen
// It can be a custom popup view, action bar, message display banner etc.
open class AANotifier: NSObject {
    
    /// AANotifier view height
    var preferedHeight: CGFloat?
    
    /// AANotifier view margins
    var margin = AAMargin()
    
    /// AANotifier view show animation
    var transitionA: AAViewAnimators = .fromTop
    
    /// AANotifier view hide animation
    var transitionB: AAViewAnimators = .toTop

    /// AANotifier view postion on screen
    var position: AANotifierPosition = .bottom
    
    /// AANotifier flag to hide on tap
    var hideOnTap: Bool = true
    
    /// AANotifier flag to hide status bar when the view will appear
    var hideStatusBar: Bool = false
    
    /// AANotifier timer for deadline
    var deadlineTimer: Timer?
    
    /// AANotifier deadline interval to disappear the view from screen
    var deadline: TimeInterval? {
        didSet {
            guard let interval = deadline else {
                return
            }
            deadlineTimer = Timer.scheduledTimer(timeInterval: interval,
                                                 target: self,
                                                 selector: #selector(hide),
                                                 userInfo: nil,
                                                 repeats: false)
        }
    }
    
    /// AANotifier animation interval
    var duration: TimeInterval = 0.8
    
    /// didTapped closure
    var didTapped: didTapped?
    
    /// AANotifier view
    open var view: UIView
    
    /// AANotifier view flag for visibility control
    var isVisible: Bool = false {
        didSet {
            
            guard isVisible != oldValue else {
                return
            }
            
            let transition = isVisible ? transitionA : transitionB
            
            view.aa_animate(duration: duration, springDamping: .none, animation: transition, completion: { flag in
                
                if flag {
                    self.toggleStatusBar(self.isVisible)
                }
            })
            
        }
    }
    
    /// UIWindow root view controller
    lazy var keyWindow: UIWindow = {
        guard let root = UIApplication.shared.keyWindow else {
            fatalError("AANotifier - Application key window not found. Please check UIWindow in AppDelegate.")
        }
        return root
    }()
    
    
    /// Tap gesture
    lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        return tapGesture
    }()
    
    /// AANotifier init method with view
    ///
    /// - Parameters:
    ///   - view: AANotifier view
    ///   - options: options
    public init(_ view: UIView, withOptions options: [AANotifierOptions]?) {
        self.view = view
        super.init()
        setOptions(options)
        addView()
    }
    
    /// AANotifier options if any
    ///
    /// - Parameter options: AANotifierOptions
    func setOptions(_ options: [AANotifierOptions]?){

        options?.forEach { (option) in
            switch option {
            case let .duration(value):
                duration = value
            case let .preferedHeight(value):
                preferedHeight = value
            case let .hideStatusBar(value):
                hideStatusBar = value
            case let .transitionA(value):
                transitionA = value
            case let .transitionB(value):
                transitionB = value
            case let .position(value):
                position = value
            case let .hideOnTap(value):
                hideOnTap = value
            case let .margins(value1, value2):
                margin = AAMargin(H: value1, V: value2)
            }
        }
    }
    
    /// AANotifier hide view
    open func hide() {
        deadlineTimer?.invalidate()
        animateNotifer(false)
    }
    
    /// AANotifier show view
    open func show() {
        animateNotifer(true)
    }
    
    /// AANotifier remove view
    open func removeView() {
        view.removeGestureRecognizer(tapGesture)
        view.removeFromSuperview()
    }
    
    /// AANotifier add view
    open func addView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tapGesture)
        keyWindow.addSubview(view)
        NSLayoutConstraint.activate(constraints)
    }

    
    /// AANotifier animate notifier with completion
    ///
    /// - Parameters:
    ///   - isVisible: visibility flag
    ///   - deadline: deadline interval
    ///   - didTapped: tapped closure
    open func animateNotifer(_ isVisible: Bool, deadline: TimeInterval? = nil, didTapped: didTapped? = nil) {
        
        self.didTapped = didTapped
        self.deadline = deadline
        self.isVisible = isVisible

    }
    
    /// didTapped Selector
    ///
    /// - Parameter sender: Tap Gesture
    func didTapped(_ sender: UITapGestureRecognizer) {
        hideOnTap ? hide() : didTapped?()
    }
    
    /// Toggle Status Bar if allowed
    ///
    /// - Parameter show: visibility flag
    func toggleStatusBar(_ show: Bool) {
        guard hideStatusBar else {
            return
        }
        UIApplication.shared.statusBarView?.isHidden = show
    }
    
}




// MARK: - AutoLayout implementation
fileprivate extension AANotifier {
    
    /// AutoLayout constraints
    var constraints: [NSLayoutConstraint] {
        
        let horizontalMargin = margin.H ?? 0
        let verticalMargin = margin.V ?? 0
        let heightConstant = preferedHeight ?? view.subviews.first!.frame.size.height
        
        let height = NSLayoutConstraint(item: view, attribute: .height,
                                        relatedBy: .equal, toItem: nil,
                                        attribute: .notAnAttribute, multiplier: 1,
                                        constant: heightConstant)
        
        let left = getConstraint(.left, constant: horizontalMargin)

        let right = getConstraint(.right, constant: -horizontalMargin)
        
        var baseline: NSLayoutConstraint
        
        switch position {
        case .top:
            baseline = getConstraint(.top, constant: verticalMargin)
        case .bottom:
            baseline = getConstraint(.bottom, constant: -verticalMargin)
        case .middle:
            baseline = getConstraint(.centerY)
        }
        
        return [height, left, right, baseline]
        
    }
    
    /// Get Layout constraints helper
    func getConstraint(_ attr: NSLayoutAttribute, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: attr, relatedBy: .equal, toItem: keyWindow, attribute: attr, multiplier: 1, constant: constant)
    }
}


