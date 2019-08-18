//
//  SearchCloseView.swift
//  ShapeShifter
//
//  Created by tskim on 18/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class SearchCloseView: UIView {

    private var isSelected: Bool = false {
        didSet {
            isSelected ? startAnimation() : stopAnimation()
        }
    }
    
    private let beginOvalPath: UIBezierPath = {
        let path = UIBezierPath(ovalIn: CGRect (x: 10, y: 10, width: 21, height: 21))
        return path
    }()
    private let afterOvalPath: UIBezierPath = {
        let path = UIBezierPath(ovalIn: CGRect (x: 2, y: 2, width: 21, height: 21))
        return path
    }()
    private let leftLine: UIBezierPath = {
        let ne_stemPath = UIBezierPath()
        ne_stemPath.move(to: CGPoint(x: 35.75, y: 13.75))
        ne_stemPath.addLine (to: CGPoint (x: 13.75, y: 35.75))
        return ne_stemPath
    }()
    private let rightLine: UIBezierPath = {
        let strokeColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let nw_stemPath = UIBezierPath()
        nw_stemPath.move (to: CGPoint(x: 13.75, y: 13.75))
        nw_stemPath.addLine (to: CGPoint (x: 41.75, y: 41.75))
        return nw_stemPath
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    private func initView() {
        let ovalLayer = CAShapeLayer()
        ovalLayer.path = beginOvalPath.cgPath
        ovalLayer.lineWidth = 3
        ovalLayer.fillColor = UIColor.clear.cgColor
        ovalLayer.strokeColor = UIColor.brown.cgColor
        ovalLayer.name = "oval"
        self.layer.addSublayer(ovalLayer)
//
        let leftLineLayer = CAShapeLayer()
        leftLineLayer.path = leftLine.cgPath
        leftLineLayer.lineWidth = 3
        leftLineLayer.strokeEnd = 0
        leftLineLayer.strokeColor = UIColor.brown.cgColor
        leftLineLayer.name = "left_line"
        self.layer.addSublayer(leftLineLayer)
//
        let rightLineLayer = CAShapeLayer()
        rightLineLayer.path = rightLine.cgPath
        rightLineLayer.lineWidth = 3
        rightLineLayer.strokeStart = 0.48
        rightLineLayer.strokeEnd = 1
        rightLineLayer.strokeColor = UIColor.brown.cgColor
        rightLineLayer.name = "right_line"
        self.layer.addSublayer(rightLineLayer)
    }
    func stopAnimation() {
        CATransaction.begin()
        if let ovalLayer = self.layer.first(name: "oval")  {
            ovalLayer.removeAllAnimations()
            let reverseTranslate = CABasicAnimation.createAnimationLayer(
                withDuration: 0.3,
                delay: 0,
                animationKeyPath: "path",
                fromValue: afterOvalPath.cgPath,
                toValue: beginOvalPath.cgPath)
            let reverseStrokeStart = CABasicAnimation.createAnimationLayer(
                withDuration: 0.35,
                delay: 0,
                animationKeyPath: "strokeStart",
                fromValue: 1,
                toValue: 0)
            ovalLayer.add(reverseTranslate, forKey: "translationOval")
            ovalLayer.add(reverseStrokeStart, forKey: "strokeStart")
        }
        if let leftLine = self.layer.first(name: "left_line") {
            leftLine.removeAllAnimations()
            let reverseStrokeEnd = CABasicAnimation.createAnimationLayer(
                withDuration: 0.3,
                delay: 0,
                animationKeyPath: "strokeEnd",
                fromValue: 1,
                toValue: 0)
            leftLine.add(reverseStrokeEnd, forKey: "strokeEnd")
        }
        if let rightLine = self.layer.first(name: "right_line") {
            rightLine.removeAllAnimations()
            let reverseStrokeStart = CABasicAnimation.createAnimationLayer(
                withDuration: 0.5,
                delay: 0,
                animationKeyPath: "strokeStart",
                fromValue: 0,
                toValue: 0.48)
            let reverseStrokeEnd = CABasicAnimation.createAnimationLayer(
                withDuration: 0.5,
                delay: 0,
                animationKeyPath: "strokeEnd",
                fromValue: 0.80,
                toValue: 1)
            rightLine.add(reverseStrokeStart, forKey: "strokeEnd")
            rightLine.add(reverseStrokeEnd, forKey: "strokeStart")
        }
        CATransaction.commit()
    }
    func startAnimation() {
        print("startAnimation")
        CATransaction.begin()
        
        if let ovalLayer = self.layer.first(name: "oval")  {
            ovalLayer.removeAllAnimations()
            let translate = CABasicAnimation.createAnimationLayer(
                withDuration: 0.3,
                delay: 0.3,
                animationKeyPath: "path",
                fromValue: beginOvalPath.cgPath,
                toValue: afterOvalPath.cgPath)

            let strokeStart = CABasicAnimation.createAnimationLayer(
                withDuration: 0.35,
                delay: 0.15,
                animationKeyPath: "strokeStart",
                fromValue: 0,
                toValue: 1)
            ovalLayer.add(translate, forKey: "translationOval")
            ovalLayer.add(strokeStart, forKey: "strokeStart")
        }
        if let leftLine = self.layer.first(name: "left_line") {
            leftLine.removeAllAnimations()
            let strokeEnd = CABasicAnimation.createAnimationLayer(
                withDuration: 0.3,
                delay: 0.5,
                animationKeyPath: "strokeEnd",
                fromValue: nil,
                toValue: 1)
            leftLine.add(strokeEnd, forKey: "strokeEnd")
        }
        if let rightLine = self.layer.first(name: "right_line") {
            rightLine.removeAllAnimations()
            let strokeStart = CABasicAnimation.createAnimationLayer(
                withDuration: 0.5,
                delay: 0.3,
                animationKeyPath: "strokeStart",
                fromValue: nil,
                toValue: 0)
            let strokeEnd = CABasicAnimation.createAnimationLayer(
                withDuration: 0.5,
                delay: 0.3,
                animationKeyPath: "strokeEnd",
                fromValue: nil,
                toValue: 0.80)
            rightLine.add(strokeEnd, forKey: "strokeEnd")
            rightLine.add(strokeStart, forKey: "strokeStart")
        }
        CATransaction.commit()
    }
    func toggle() {
        isSelected = !isSelected
    }
}

extension CABasicAnimation {
    open class func createAnimationLayer(
        withDuration duration: TimeInterval,
        delay: TimeInterval,
        animationKeyPath: String,
        fromValue from: Any?,
        toValue to: Any?
    ) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: animationKeyPath)
        animation.beginTime = CACurrentMediaTime() + delay
        animation.fromValue = from
        animation.toValue = to
        animation.isRemovedOnCompletion = false
        animation.duration = duration
        animation.fillMode = .forwards
        return animation
    }
}

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}

extension CALayer {
    func first(name: String) -> CALayer? {
        return self.sublayers?.first {
            $0.name == name
        }
    }
}
