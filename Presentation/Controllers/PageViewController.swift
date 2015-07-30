//
//  PageViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 16.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageControllers = [String]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self;
        self.delegate = self;
        
        self.pageControllers = [
            "FrontPageViewController",
            "ThemeListViewController",
            "TypefaceViewController",
            "PointSizeViewController",
            "FontMetricksViewController",
            "LeadingViewController",
            "LigaturesViewController",
            "KerningViewController",
            "TypographyViewController",
            "TextKitStackViewController",
            "TextStorageViewController",
            "TextContainerViewController",
            "LayoutManagerViewController",
            "TextKitStackProgrammaticallyViewController",
            "SubclassTextStorageViewController",
            "TextStorageExampleViewController",
            "TextContainerExampleViewController",
            "TextKitFeaturesViewController",
            "LinksViewController",
        ]
        
        let firstSlideViewController = self.viewControllerAtIndex(0)
        self.setViewControllers([firstSlideViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let slideViewController = viewController as? SlideViewController
        var index = slideViewController?.slideIndex
        
        if index == nil || index == 0 {
            return nil
        }
        
        currentIndex = index! - 1

        return viewControllerAtIndex(currentIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        let slideViewController = viewController as? SlideViewController
        var index = slideViewController?.slideIndex
        
        if index == nil  || index == self.pageControllers.count - 1 {
            return nil
        }
        
        currentIndex = index! + 1
        
        return viewControllerAtIndex(currentIndex)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        let storyboardId = self.pageControllers[index]
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier(storyboardId) as! SlideViewController
        controller.slideIndex = index
        
        if index > 0 {
            controller.setSlidesAnnotation("\(index)")
        }
        
        return controller
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}


extension UIViewController{
    func setSlidesAnnotation(annotation: String) {
        let tag = 50
        
        view.viewWithTag(tag)?.removeFromSuperview()
        let label = UILabel()
        let verticalConstraint = NSLayoutConstraint(
            item: label,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0)
        let horizontalConstraint = NSLayoutConstraint(
            item: label,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: -10)
        label.textColor = UIColor.whiteColor()
        label.text = annotation
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.tag = tag
        label.font = UIFont.systemFontOfSize(25.0)
        view.addSubview(label)
        view.addConstraints([verticalConstraint, horizontalConstraint])
    }
}