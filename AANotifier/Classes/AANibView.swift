//
//  AANibView.swift
//  AANotifier
//
//  Created by Engr. Ahsan Ali on 11/02/2017.
//  Copyright © 2017 AA-Creations. All rights reserved.
//

/// MARK:- AANibView - encapsulating the custom xib based UIView
open class AANibView: UIView {
    
    /// View
    var view:UIView!
    
    /// Nib name
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    //MARK: Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    //MARK: loadViewFromNib
    private func loadViewFromNib() {
        view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as? UIView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        addSubview(view)
        viewDidLoad()
    }
    
    
    /// Method for overriding after subview loading
    open func viewDidLoad() {
        // Perform actions in over-rided method
        
    }
    
}


// MARK: - UIView extension
extension UIView {
    
    /// Load from nib
    open class func fromNib<A: UIView> (nibName name: String, bundle: Bundle = .main) -> A? {
        let nibViews = bundle.loadNibNamed(name, owner: self, options: nil)
        return nibViews?.first as? A
    }
    
    /// Load from nib
    open class func fromNib<T: UIView>() -> T? {
        return fromNib(nibName: String(describing: T.self))
    }
    
}
