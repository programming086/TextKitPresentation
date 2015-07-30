//
//  ViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 16.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class FrontPageViewController: SlideViewController {

    @IBOutlet weak var backgroundTextView: UITextView!
    @IBOutlet var excludeViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var paths = [UIBezierPath]()
        for (index, view) in enumerate(excludeViews) {
            let viewFrame = view.frame
            let exclusionRect = self.view.convertRect(viewFrame, toView:backgroundTextView)
            let exclusion = UIBezierPath(rect:exclusionRect);
            paths.append(exclusion)
        }
        
        backgroundTextView.textContainer.exclusionPaths = paths
    }
}

