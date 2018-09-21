//
//  AANotifier+Helper.swift
//  AANotifier
//
//  Created by Engr. Ahsan Ali on 11/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

import AAViewAnimator

/// tapped closure
public typealias didTapped = () -> Void

/// AANotifier position
///
/// - top: top of screen
/// - bottom: bottom of screen
/// - middle: middle of screen
public enum AANotifierPosition {
    case top, bottom, middle
}

/// AAMargin margins for AANotifier
struct AAMargin {
    var H: CGFloat?
    var V: CGFloat?
}

/// AANotifierOptions for AANotifier
///
/// - duration: time interval for animation
/// - preferedHeight: height of AANotifier
/// - hideStatusBar: flag for statusbar visibility
/// - transitionA: AANotifier show animation
/// - transitionB: AANotifier hide animation
/// - position: AANotifier position
/// - hideOnTap: flag for hide on tap
/// - margins: margins horizontal and vertical
/// - deadline: dismiss deadline
public enum AANotifierOptions {
    
    case preferedHeight(CGFloat)
    case hideStatusBar
    case transitionA(AAViewAnimators, TimeInterval)
    case transitionB(AAViewAnimators, TimeInterval)
    case position(AANotifierPosition)
    case hideOnTap
    case deadline(TimeInterval)
    case margins(H: CGFloat?, V: CGFloat?)
}

// MARK: - UIApplication extension
extension UIApplication {
    
    /// Status bar view
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
