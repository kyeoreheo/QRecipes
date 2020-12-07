//
//  ProgressBar.swift
//  QRecipes
//
//  Created by Kyo on 9/23/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    private var backgroundLayer = CAShapeLayer()
    private var foregroundLayer = CAShapeLayer()
    private var textLayer = CATextLayer()
    
    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdated()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
        backgroundLayer = createCircularLayer(rect: rect,
                          strokeColor: UIColor.primeOrange.cgColor,
                          fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        layer.addSublayer(backgroundLayer)

        foregroundLayer = createCircularLayer(rect: rect,
                          strokeColor: UIColor.white.cgColor,
                          fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        layer.addSublayer(foregroundLayer)
        foregroundLayer.strokeEnd = 1
    }
    
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        
        let width = rect.width
        let height = rect.height
                
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let startAngle = -CGFloat.pi / 2 // was -
        let endAngle = (startAngle + 2 * CGFloat.pi)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .butt
        
        return shapeLayer
    }
    
    func didProgressUpdated() {
        foregroundLayer.strokeEnd = progress//1 - progress
        //print("DEBUG:- \(progress)")
    }
}
