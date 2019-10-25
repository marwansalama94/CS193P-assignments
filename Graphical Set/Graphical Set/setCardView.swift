//
//  setCardView.swift
//  Graphical Set
//
//  Created by Marwan Salama on 10/24/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

@IBDesignable
class setCardView: UIView {

    @IBInspectable
    var shape: Int = 1 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var pipsCount : Int = 3 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var shade :Int = 2 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var color : UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isSelected : Bool = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private lazy var grid = Grid(layout:Grid.Layout.dimensions(rowCount: pipsCount, columnCount: 1), frame: bounds.insetBy(dx: 10, dy: 10))
    
    private func drawSingleSquare(at location: CGRect){
        let path = UIBezierPath(rect: location)
        color.setFill()
        color.setStroke()
        path.fill()
        path.stroke()
    }
    private func drawSingleTriangle(at location: CGRect){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: location.maxX, y: location.maxY))
        path.addLine(to: CGPoint(x: location.midX, y: location.minY))
        path.addLine(to: CGPoint(x: location.minX, y: location.maxY))
        path.close()
        color.setFill()
        color.setStroke()
        path.fill()
        path.stroke()
        
    }
    private func drawSingleCircle(at location: CGRect){
        let path = UIBezierPath(ovalIn: location)
        color.setFill()
        color.setStroke()
        path.fill()
        path.stroke()
    }
    
    private func shapeToDrawDecider(at location:CGRect){
        switch shape{
        case 1:
            drawSingleSquare(at: location)
        case 2:
            drawSingleTriangle(at: location)
        case 3:
            drawSingleCircle(at: location)
        default:
            break
        }
    }
    
    override func draw(_ rect: CGRect) {
        for index in 0..<pipsCount{
            if let location = grid[index]{
                shapeToDrawDecider(at: location.insetBy(dx: 0, dy: 10))
            }
        }
        if isSelected{
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 7
        }
    }

}
