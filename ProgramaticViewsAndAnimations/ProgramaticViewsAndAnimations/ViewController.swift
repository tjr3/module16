//
//  ViewController.swift
//  ProgramaticViewsAndAnimations
//
//  Created by Tyler on 5/30/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topLeftButton = UIButton()
    let topRightButton = UIButton()
    let bottomLeftButton = UIButton()
    let bottomRightButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupConstraints()
    }
    
    func setupButtons() {
        // Set Colors
        topLeftButton.backgroundColor = .greenColor()
        topRightButton.backgroundColor = .yellowColor()
        bottomLeftButton.backgroundColor = .redColor()
        bottomRightButton.backgroundColor = UIColor(red: 0.537, green: 0.506, blue: 0.925, alpha: 1.0)
        
        // Add targets for Color Animation
        topLeftButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        topRightButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        bottomLeftButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        bottomRightButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)
        
        // Add target for Shake Animation
        topLeftButton.addTarget(self, action: #selector(ViewController.buttonExited(_:)), forControlEvents: .TouchDragExit)
        topRightButton.addTarget(self, action: #selector(ViewController.buttonExited(_:)), forControlEvents: .TouchDragExit)
        bottomLeftButton.addTarget(self, action: #selector(ViewController.buttonExited(_:)), forControlEvents: .TouchDragExit)
        bottomRightButton.addTarget(self, action: #selector(ViewController.buttonExited(_:)), forControlEvents: .TouchDragExit)
        
        // Add Buttons to our View
        view.addSubview(topLeftButton)
        view.addSubview(topRightButton)
        view.addSubview(bottomLeftButton)
        view.addSubview(bottomRightButton)
    }
    
    func buttonTapped() {
        let topLeftColor = topLeftButton.backgroundColor
        let topRightColor = topRightButton.backgroundColor
        let bottomLeftColor = bottomLeftButton.backgroundColor
        let bottomRightColor = bottomRightButton.backgroundColor
        
        UIView.animateWithDuration(0.25) {
        self.topLeftButton.backgroundColor = bottomLeftColor
        self.topRightButton.backgroundColor = topLeftColor
        self.bottomLeftButton.backgroundColor = bottomRightColor
        self.bottomRightButton.backgroundColor = topRightColor
        }
    }
    
    
    func buttonExited(sender: UIButton) {
        view.bringSubviewToFront(sender)
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [sender.frame.origin.x + sender.frame.width/2, sender.frame.origin.x + sender.frame.width/2 - 15, sender.frame.origin.x + sender.frame.width/2, sender.frame.origin.x + sender.frame.width/2 + 15, sender.frame.origin.x + sender.frame.width/2]
        animation.keyTimes = [0, 0.25, 0.50, 0.75, 1]
        animation.duration = 0.5
        animation.repeatCount = 5.0
        sender.layer.addAnimation(animation, forKey: "shake")
        
    }
    
    func setupConstraints() {
        
        topLeftButton.translatesAutoresizingMaskIntoConstraints = false
        topRightButton.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftButton.translatesAutoresizingMaskIntoConstraints = false
        bottomRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Heigth & Width
        let topButtonWidths = NSLayoutConstraint(item: topLeftButton, attribute: .Width, relatedBy: .Equal, toItem: topRightButton, attribute: .Width, multiplier: 1.0, constant: 0)
        let topButtonHeigths = NSLayoutConstraint(item: topLeftButton, attribute: .Height, relatedBy: .Equal, toItem: bottomRightButton, attribute: .Height, multiplier: 1.0, constant: 0)
        let bottomButtonWidths = NSLayoutConstraint(item: bottomLeftButton, attribute: .Width, relatedBy: .Equal, toItem: bottomRightButton, attribute: .Width, multiplier: 1.0, constant: 0)
        let bottomButtonHeights = NSLayoutConstraint(item: bottomLeftButton, attribute: .Height, relatedBy: .Equal, toItem: bottomRightButton, attribute: .Height, multiplier: 1.0, constant: 0)
        
        view.addConstraints([topButtonWidths, topButtonHeigths, bottomButtonWidths, bottomButtonHeights])
        
        // topLeft set TOP and LEADING constraints
        let topLeftLeadingConstraints = NSLayoutConstraint(item: topLeftButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let topLeftTopConstraint = NSLayoutConstraint(item: topLeftButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
    
        // topLeft set tailing to topRight leading
        let topLeftToTopRight = NSLayoutConstraint(item: topLeftButton, attribute: .Trailing, relatedBy: .Equal, toItem: topRightButton, attribute: .Leading, multiplier: 1.0, constant: 0)
        
        // topLeft set bottom to bottomLeft top
        let topLeftBottomToBottomLeft = NSLayoutConstraint(item: topLeftButton, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLeftButton, attribute: .Top, multiplier: 1.0, constant: 0)
        
        // topRight set TOP and TRAILING constraints
        let topRightTopContraint = NSLayoutConstraint(item: topRightButton, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        let topRightTrailingConstraint = NSLayoutConstraint(item: topRightButton, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        // bottomLeft set LEADING and BOTTOM
        let bottomLeftLeadingConstraint = NSLayoutConstraint(item: bottomLeftButton, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let bottomLeftBottomConstraint = NSLayoutConstraint(item: bottomLeftButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        // bottomLeft set TRAILING
        let bottomLeftTrailingToBottomRightLeadingConstraint = NSLayoutConstraint(item: bottomLeftButton, attribute: .Trailing, relatedBy: .Equal, toItem: bottomRightButton, attribute: .Leading, multiplier: 1.0, constant: 0)
        
        // topRightBottom to BottomRightTop
        let topRightToBottomRightTop = NSLayoutConstraint(item: topRightButton, attribute: .Bottom, relatedBy: .Equal, toItem: bottomRightButton, attribute: .Top, multiplier: 1.0, constant: 0)
        
        // bottomRight Bottom and Trailing
        let bottomRightBottomConstraint = NSLayoutConstraint(item: bottomRightButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let bottomRightTrailingConstraint = NSLayoutConstraint(item: bottomRightButton, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        
        view.addConstraints([topLeftLeadingConstraints, topLeftTopConstraint, topLeftToTopRight, topLeftBottomToBottomLeft, topRightTopContraint, topRightTrailingConstraint, bottomLeftLeadingConstraint, bottomLeftBottomConstraint, bottomLeftTrailingToBottomRightLeadingConstraint, topRightToBottomRightTop, bottomRightBottomConstraint, bottomRightTrailingConstraint])
        
        
    }
    
}

