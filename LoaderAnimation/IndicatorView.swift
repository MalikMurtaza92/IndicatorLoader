//
//  IndicatorView.swift
//  LoaderAnimation
//
//  Created by Murtaza Mehmood on 23/02/2023.
//

import UIKit

class IndicatorView: UIView {
    
    private let replicator = CAReplicatorLayer()
    private let bar = CALayer()
    
    private struct Constant {
        static let instanceCount:CGFloat = 8
        static let widthScale: CGFloat = 0.5
        static let heightScale: CGFloat = 0.2
        static let animationDuration: CGFloat = 0.75
    }
    
    var color: UIColor = UIColor.gray {
        didSet {
            replicator.instanceColor = color.cgColor
        }
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLoaderLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addLoaderLayer()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        replicator.frame = bounds
        let width = (halfWidth * Constant.widthScale)
        let heigth = halfHeight * Constant.heightScale
        bar.frame = CGRect(x: (halfWidth - (width)) / 2,
                           y: halfHeight - ((heigth) / 2),
                           width: width,
                           height: heigth)
    }
    
    private func addLoaderLayer() {
        replicator.frame = bounds
        layer.addSublayer(replicator)
        
        
        let width = (halfWidth * Constant.widthScale)
        let heigth = halfHeight * Constant.heightScale
        
        bar.frame = CGRect(x: (halfWidth - (width)) / 2,
                           y: halfHeight - ((heigth) / 2),
                           width: width,
                           height: heigth)
        bar.backgroundColor = UIColor.white.cgColor
        bar.cornerRadius = (heigth) / 2
        
        replicator.addSublayer(bar)
        
        replicator.instanceCount = Int(Constant.instanceCount)
        replicator.instanceColor  = color.cgColor
        replicator.instanceAlphaOffset = -1 / Float(Constant.instanceCount)
        replicator.instanceTransform = CATransform3DMakeRotation(degreeToRadian(360 / Constant.instanceCount), 0.0, 0.0, 1.0)
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 0.7
        animation.duration = Constant.animationDuration
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        bar.add(animation, forKey: nil)
        replicator.instanceDelay = Constant.animationDuration / Constant.instanceCount
    }
    
    func stopAnimation() {
        bar.removeAllAnimations()
    }
    
    
    private func degreeToRadian(_ degree: CGFloat) -> CGFloat {
        return degree * .pi / 180
    }
    
}
