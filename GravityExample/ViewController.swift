//
//  ViewController.swift
//  GravityExample
//
//  Created by Mike Kavouras on 9/1/16.
//  Copyright © 2016 Mike Kavouras. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let block = UIView()
    
    lazy var animator: UIDynamicAnimator = {
        let a = UIDynamicAnimator(referenceView: self.view)
        return a
    }()
    
    lazy var gravity: UIGravityBehavior = {
        let g = UIGravityBehavior()
        self.animator.addBehavior(g)
        return g
    }()
    
    lazy var collision: UICollisionBehavior = {
        let c = UICollisionBehavior()
        c.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(c)
        return c
    }()
    
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        block.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        block.backgroundColor = .red
        
        view.addSubview(block)
        
        collision.addItem(block)
        gravity.addItem(block)
        
        motionManager.startDeviceMotionUpdates(to: motionQueue) { motion, error in
            guard let gravity = motion?.gravity else { return }
            DispatchQueue.main.async {
                self.gravity.gravityDirection = CGVector(dx: gravity.x, dy: -gravity.y)
            }
        }
    }
}

