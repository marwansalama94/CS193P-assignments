//
//  singleObjectView.swift
//  Set HW4
//
//  Created by Marwan Salama on 12/13/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

@IBDesignable
class singleObjectView: UIView {
    
    
    var suit : setCard.Suit?
    var color : setCard.Color?
    var shape : setCard.Shape?

    override func draw(_ rect: CGRect) {
        // Drawing code
        drawTheShape(withColor: colorDecide())
    }
    private func drawTheShape(withColor color:UIColor){
        let path = UIBezierPath()
        path.lineWidth=2
        if let suit = self.suit{
            switch suit{
            case .oval:
                //path.move(to: CGPoint(x: bounds.midX, y: bounds.midY))
                path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: (bounds.maxX-bounds.minY-4)/2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
                path.close()
            case .triangle:
                path.move(to: CGPoint(x: bounds.midX, y: bounds.minY+1))
                path.addLine(to: CGPoint(x:bounds.maxX , y:bounds.maxY-1))
                path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY-1))
                path.close()
            case .square:
                path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
                path.addLine(to: CGPoint(x:bounds.maxX,y: bounds.minY))
                path.addLine(to: CGPoint(x:bounds.maxX,y: bounds.maxY))
                path.addLine(to: CGPoint(x:bounds.minX,y: bounds.maxY))
                path.close()
            }
        }
        if let shape = self.shape{
            switch shape{
            case .empty:
                color.setStroke()
            case .fill:
                color.setStroke()
                color.setFill()
                path.fill()
            case .stroke:
                path.addClip()
                for i in stride(from: path.bounds.minY, to: path.bounds.maxY, by: 5){
                    path.move(to: CGPoint(x: bounds.maxX, y: i))
                    path.addLine(to: CGPoint(x: bounds.minY, y: i))
                }
                color.setStroke()
            }
        }
        
        path.stroke()
    }
    

    private func colorDecide()->UIColor{
        if let color = self.color{
            switch color{
            case .green:
                return UIColor.green
            case .red:
                return UIColor.red
            case .purple:
                return UIColor.purple
            }
        }
        return UIColor.black
    }

}

