//
//  ViewController.swift
//  magical grid
//
//  Created by macOS on 8/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIGestureRecognizerDelegate{
    
    var cells = [String : UIView]()
    var prevCell : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = view.frame.width
        let side = width / 15
        for j in 0...50 {
            for i in 0...15 {
                let squareView = UIView(frame: CGRect(x: side * CGFloat(i), y: side * CGFloat(j), width: side, height: side))
                let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
                squareView.backgroundColor = color
                view.addSubview(squareView)
                cells["\(i),\(j)"] = squareView
            }
        }

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        print(gesture)
        view.addGestureRecognizer(gesture)
    }

    @objc func handleGesture(gesture : UIPanGestureRecognizer) {
        let location = gesture.location(in: view)

        let width = view.frame.width / 15

        let i = Int(location.x / width)
        let j = Int(location.y / width)
        let cellView = cells["\(i),\(j)"]
        if cellView != prevCell {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                cellView?.layer.transform = CATransform3DMakeScale(3, 3, 3)
                self.view.bringSubview(toFront: cellView!)
            }, completion: nil)
            prevCell = cellView
        }

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.prevCell?.layer.transform = CATransform3DIdentity
        }, completion: nil)
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                cellView?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        print(gesture)
    }

}

