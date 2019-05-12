//
//  StretchHeader.swift
//  StretchHeader
//
//  Created by Mike Saradeth on 5/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

class StretchHeader: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "header"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleToFill
        return imageView
    }()
    private var heightConstraint: NSLayoutConstraint!
    var defaultHeight: CGFloat
    var maxHeight: CGFloat
    
    init(height: CGFloat, maxHeight: CGFloat) {
        self.defaultHeight = height
        self.maxHeight = maxHeight
        super.init(frame: .zero)
        setupImageView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init?(coder aDedoder: NSCoder) not implemented")
    }

    //MARK: set up views
    private func setupImageView() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func anchorToSuperView() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        heightConstraint = self.heightAnchor.constraint(equalToConstant: defaultHeight)
        self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true    
        NSLayoutConstraint.activate([heightConstraint])
    }
    
    
    //MARK: functions to animate view
    func stretch(contentOffset: CGPoint) {
        let newHeight = heightConstraint.constant - contentOffset.y
        guard newHeight >= defaultHeight && newHeight <= maxHeight else { return }
            
        heightConstraint.constant = newHeight
        layoutIfNeeded()
    }
    func setToDefaultHeight() {
        heightConstraint.constant = defaultHeight
        animate()
    }
    
    func animate(duration: TimeInterval = 0.4) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { self.layoutIfNeeded() },
                       completion: nil)
    }
    
}
