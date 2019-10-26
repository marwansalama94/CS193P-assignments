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
    
    private var grid = Grid(layout: Grid.Layout.dimensions(rowCount: 1, columnCount: 1))//{didSet {setNeedsDisplay(); setNeedsLayout()}}
    
    private func drawSingleSquare(at location: CGRect){
        let path = UIBezierPath(rect: location)
        color.setFill()
        color.setStroke()
        addShade(toPath: path)
    }
    private func drawSingleTriangle(at location: CGRect){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: location.maxX, y: location.maxY))
        path.addLine(to: CGPoint(x: location.midX, y: location.minY))
        path.addLine(to: CGPoint(x: location.minX, y: location.maxY))
        path.addLine(to: CGPoint(x: location.maxX, y: location.maxY))
        
        color.setFill()
        color.setStroke()
        addShade(toPath: path)
        
    }
    
    private func addShade(toPath path : UIBezierPath ){
        if shade == 2{
            path.fill()
        }else if shade == 3 {
            strokePath(path)
        }else{
            path.stroke()
        }
    }
    
    private func drawSingleCircle(at location: CGRect){
        let path = UIBezierPath(ovalIn: location)
        color.setFill()
        color.setStroke()
        addShade(toPath: path)
    }
    
    private func strokePath(_ path : UIBezierPath){
        if let context = UIGraphicsGetCurrentContext(){
            context.saveGState()
            path.addClip()
            for offset in stride(from: bounds.minY, to: bounds.maxY, by: 10){
                path.move(to: CGPoint(x: bounds.minX, y: offset))
                path.addLine(to: CGPoint(x: bounds.maxX, y: offset))
            }
            path.stroke()
            context.restoreGState()
        }
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
        grid.dimensions = (pipsCount,1)
        grid.frame = bounds.insetBy(dx: 10, dy: 10)
        for index in 0..<pipsCount{
            if let location = grid[index]{
                shapeToDrawDecider(at: location.insetBy(dx: 0, dy: 10))
            }
        }
        layer.borderWidth = 5
        if isSelected{
            layer.borderColor = UIColor.blue.cgColor
        }else{
            layer.borderColor = nil
        }
    }

}
