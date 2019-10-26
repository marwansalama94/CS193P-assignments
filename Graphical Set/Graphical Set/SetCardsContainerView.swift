//
//  SetCardsContainerView.swift
//  Graphical Set
//
//  Created by Marwan Salama on 10/26/19.
//  Copyright © 2019 Marwan Salama. All rights reserved.
//

import UIKit

class SetCardsContainerView: UIView {

    var grid = Grid(layout: Grid.Layout.dimensions(rowCount: 1, columnCount: 1)){didSet{setNeedsDisplay(); setNeedsLayout()}}
    override func draw(_ rect: CGRect) {
        grid.frame = bounds
        for view in subviews{
            view.frame = grid[subviews.firstIndex(of: view)!]!
        }
        setNeedsLayout()
    }
    

}
