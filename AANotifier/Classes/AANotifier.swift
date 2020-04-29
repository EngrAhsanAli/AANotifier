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
open class AANotifier {
    
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
    
    /// AANotifier animation interval
    var durationA: TimeInterval = 0.8
    
    /// AANotifier animation interval
    var durationB: TimeInterval = 0.8
    
    /// AANotifier flag to hide on tap
    var hideOnTap: Bool = false
    
    /// AANotifier timer for deadline
    var deadlineTimer: Timer?
    
    /// AANotifier deadline interval to disappear the view from screen
    open var deadline: TimeInterval? {
        didSet {
            setTimer()
        }
    }
    
    
    /// Did Tapped closure
    @objc open var didTapped: didTapped?
    
    /// AANotifier view
    var view: UIView
    
    /// UIWindow root view controller
    lazy var keyWindow: UIWindow = {
        guard let root = UIApplication.shared.keyWindow else {
            fatalError("AANotifier - Application key window not found. Please check UIWindow in AppDelegate.")
        }
        return root
    }()
    
    
    /// Tap gesture
    lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTappedAction(_:)))
        tapGesture.numberOfTapsRequired = 1
        return tapGesture
    }()
    
    /// AANotifier init method with view
    ///
    /// - Parameters:
    ///   - view: AANotifier view
    ///   - options: options
    public init(_ view: UIView, withOptions options: [AANotifierOptions]) {
        self.view = view
        setOptions(options)
    }
    
    /// Starts animation
    ///
    /// - Parameter isVisible: Visibility flag
    private func startAnimation(_ isVisible: Bool) {
        if isVisible {
            addNotifierView()
        }

        let transition = isVisible ? transitionA : transitionB
        let duration   = isVisible ? durationA : durationB
        view.aa_animate(duration: duration, repeatCount: 1, springDamping: .none, animation: transition, completion: { isAnimating, view in
            
            if !isAnimating && !isVisible {
                self.removeNotifierView()
            }
            
            
        })
    }
    
    /// AANotifier options if any
    ///
    /// - Parameter options: AANotifierOptions
    private func setOptions(_ options: [AANotifierOptions]){

        options.forEach { (option) in
            switch option {
            case let .preferedHeight(value):
                preferedHeight = value
            case let .transitionA(value, duration):
                transitionA = value
                durationA = duration
            case let .transitionB(value, duration):
                transitionB = value
                durationB = duration
            case let .position(value):
                position = value
            case .hideOnTap:
                hideOnTap = true
            case let .deadline (value):
                deadline = value
            case let .margins(value1, value2):
                margin = AAMargin(H: value1, V: value2)
            }
        }
    }
    
    /// AANotifier hide view
    @objc open func hide() {
        deadlineTimer?.invalidate()
        startAnimation(false)
    }
    
    /// AANotifier animate notifier with completion
    open func show() {
        setTimer()
        startAnimation(true)
    }
    
    /// AANotifier remove view
    private func removeNotifierView() {
        deadlineTimer?.invalidate()
        self.view.removeGestureRecognizer(self.tapGesture)
        self.view.removeFromSuperview()
        NSLayoutConstraint.deactivate(constraints)
    }
    
    /// AANotifier add view
    private func addNotifierView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tapGesture)
        keyWindow.addSubview(view)
        NSLayoutConstraint.activate(constraints)
        
    }

    /// didTappedAction Selector
    ///
    /// - Parameter sender: Tap Gesture
    @objc private func didTappedAction(_ sender: UITapGestureRecognizer) {
        if hideOnTap {
            hide()
        }
        didTapped?()
    }
    
    func setTimer() {
        deadlineTimer?.invalidate()
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




// MARK: - AutoLayout implementation
fileprivate extension AANotifier {
    
    /// AutoLayout constraints
    var constraints: [NSLayoutConstraint] {
        
        let horizontalMargin = margin.H ?? 0
        var verticalMargin = margin.V ?? 0
        var heightConstant = preferedHeight ?? view.subviews.first!.frame.size.height
        
        var baseline: NSLayoutConstraint
        
        switch position {
        case .top:
            let statusBarHeight = statusBarFrame.height
            if statusBarHeight > 0 {
                let statusBarHeight = statusBarHeight + 5
                heightConstant += statusBarHeight
                verticalMargin -= statusBarHeight
            }
            baseline = getConstraint(.top, constant: verticalMargin)
        case .bottom:
            baseline = getConstraint(.bottom, constant: -verticalMargin)
        case .middle:
            baseline = getConstraint(.centerY)
        }
        
        let height = NSLayoutConstraint(item: view, attribute: .height,
                                        relatedBy: .equal, toItem: nil,
                                        attribute: .notAnAttribute, multiplier: 1,
                                        constant: heightConstant)
        
        let left = getConstraint(.left, constant: horizontalMargin)

        let right = getConstraint(.right, constant: -horizontalMargin)
        
        return [height, left, right, baseline]
        
    }
    
    /// Get Layout constraints helper
    func getConstraint(_ attr: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: attr, relatedBy: .equal, toItem: keyWindow, attribute: attr, multiplier: 1, constant: constant)
    }
    
    var statusBarFrame: CGRect {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        return statusBarFrame
    }
}


