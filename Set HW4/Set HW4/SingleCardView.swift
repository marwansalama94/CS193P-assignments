//
//  SingleCardView.swift
//  Set HW4
//
//  Created by Marwan Salama on 12/13/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

@IBDesignable
class SingleCardView: UIView {
    
    var suit : setCard.Suit?
    var count : setCard.Count?
    var color : setCard.Color?
    var shape : setCard.Shape?
    var isPresented = false{ didSet {setNeedsDisplay();setNeedsLayout()}}
    var isSelected = false { didSet {setNeedsDisplay();setNeedsLayout()}}
    var grid = Grid(layout: Grid.Layout.dimensions(rowCount: 1, columnCount: 1))
    
    

    override func draw(_ rect: CGRect) {
        if isSelected{
            layer.borderWidth = 5
            layer.borderColor = UIColor.red.cgColor
        }else{
            layer.borderWidth = 1
            layer.borderColor = UIColor.purple.cgColor
        }
        grid.frame = rect
        //setTheCard()

    }
    private func setTheCard(){
        if(isPresented){
            backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            if let count = self.count{
                switch count{
                case .one:
                    grid.dimensions = (1,1)
                    grid.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                    drawSingleShape(in: grid[0]!.zoom(by: 0.3))
                case .two:
                    grid.dimensions = (1,2)
                    grid.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                    drawSingleShape(in: grid[0]!.zoom(by: 0.5))
                    drawSingleShape(in: grid[1]!.zoom(by: 0.5))
                case .three:
                    grid.dimensions = (1,3)
                    grid.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                    drawSingleShape(in: grid[0]!.zoom(by: grid.aspectRatio))
                    drawSingleShape(in: grid[1]!.zoom(by: grid.aspectRatio))
                    drawSingleShape(in: grid[2]!.zoom(by: grid.aspectRatio))
                }
            }
        }else{
            backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        
    }
    
    private func drawSingleShape(in rect:CGRect){
        let view = singleObjectView(frame: rect)
        view.color = color
        view.shape = shape
        view.suit = suit
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        addSubview(view)
    }
    override func layoutSubviews() {
        clearSubviews()
        setTheCard()
    }
    
}




extension CGRect {
    func inset(by size: CGSize) -> CGRect {
        return CGRect(x: self.minX, y: self.minY, width: self.maxX, height: self.maxY-(size.height+20))
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = newWidth
        return insetBy(dx: (width - newWidth) / 3, dy: (height - newHeight) / 3)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
