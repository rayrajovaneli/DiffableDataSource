//
//  UIView+Constraints.swift
//  DiffableDataSource
//
//  Created by user218260 on 5/26/22.
//

import UIKit

public struct AnchoredConstraints{
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}


extension UIView {
    
    @discardableResult
    open func anchor(top: NSLayoutYAxisAnchor?,
                     leading: NSLayoutXAxisAnchor?,
                     trailing: NSLayoutXAxisAnchor?,
                     bottom: NSLayoutYAxisAnchor?,
                     padding: UIEdgeInsets = .zero,
                     size: CGSize = .zero) -> AnchoredConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.trailing,
         anchoredConstraints.bottom,
         anchoredConstraints.width,
         anchoredConstraints.height].forEach {
            $0?.isActive = true
        }
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(top: NSLayoutYAxisAnchor) -> AnchoredConstraints{
    
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.top = topAnchor.constraint(greaterThanOrEqualTo: top)
        return anchoredConstraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(bottom: NSLayoutYAxisAnchor) -> AnchoredConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.bottom = bottomAnchor.constraint(greaterThanOrEqualTo: bottom)
        return anchoredConstraints
    }
    
    
    @discardableResult
    open func anchorGreaterThanOrEqual(leading: NSLayoutXAxisAnchor) -> AnchoredConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.leading = leadingAnchor.constraint(greaterThanOrEqualTo: leading)
        return anchoredConstraints
    }
    
    @discardableResult
    open func anchorGreaterThanOrEqual(trailing: NSLayoutXAxisAnchor) -> AnchoredConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredContraints = AnchoredConstraints()
        anchoredContraints.trailing = trailingAnchor.constraint(greaterThanOrEqualTo: trailing)
        return anchoredContraints
    }
    
    @discardableResult
    open func fillSuperView(padding: UIEdgeInsets = .zero) -> AnchoredConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        let anchoredConstraints = AnchoredConstraints()
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewLeadingAnchor = superview?.leadingAnchor,
              let superviewTrailingAnchor = superview?.trailingAnchor else{
            return anchoredConstraints
        }
        
        return anchor(top: superviewTopAnchor,
                      leading: superviewLeadingAnchor,
                      trailing: superviewTrailingAnchor,
                      bottom: superviewBottomAnchor,
                      padding: padding)
      
    }
    
    
    @discardableResult
    open func fillSuperViewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints{
        
        let anchoredConstraints = AnchoredConstraints()
        if #available(iOS 11.0, *){
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                    let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                    let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                    let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor  else { return anchoredConstraints }
            
            return anchor(top: superviewTopAnchor,
                          leading: superviewLeadingAnchor,
                          trailing: superviewTrailingAnchor,
                          bottom: superviewBottomAnchor,
                          padding: padding)
        } else {
            return anchoredConstraints
        }
        
        
    }
    
    open func centerInSuperView(size: CGSize = .zero ){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor{
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor{
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    open func centerXTo(_ anchor: NSLayoutXAxisAnchor){
        
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    open func centerYTo(_ anchor: NSLayoutYAxisAnchor){
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor).isActive = true
    }
    
    
    open func centerXToSuperView(){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor{
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
    }
    
    open func centerYToSuperView(){
    
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor{
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
            
        }
    }
    
    @discardableResult
    open func constrainHeight(_ constant: CGFloat) -> AnchoredConstraints{
    
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.height?.isActive = true
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func constrainWidth(_ constant: CGFloat) -> AnchoredConstraints{
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
        anchoredConstraints.width?.isActive = true
        
        return anchoredConstraints
    }
    
    @discardableResult
    open func constrainSize(_ constant: CGSize) -> AnchoredConstraints{
    
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant.width)
        anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant.height)
        anchoredConstraints.width?.isActive = true
        anchoredConstraints.height?.isActive = true
        
        return anchoredConstraints
    }
}
