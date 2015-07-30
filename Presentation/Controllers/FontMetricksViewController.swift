//
//  FontMetricksViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class FontMetricksViewController: TextViewSlideViewController {

    override func createAttributedString() -> NSAttributedString {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute : "Times New Roman"])
        let normalFont = UIFont(descriptor: fontDescriptor, size: 300)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let attributes = [NSFontAttributeName : normalFont, NSForegroundColorAttributeName : UIColor.whiteColor(), NSParagraphStyleAttributeName : paragraphStyle];
        var attributedString = NSMutableAttributedString(string: "yKbx", attributes: attributes)
        return attributedString
    }
    
    override func setupLayoutManager() {
        layoutManager.showBaseline = true
        layoutManager.showMeanline = true
        layoutManager.showBoundingRect = true
    }
    
    @IBAction func capHeightSwitchValueChanged(sender: UISwitch) {
        layoutManager.showCapHeight = sender.on
        updateView()
    }
    @IBAction func xHeightSwitchValueChanged(sender: UISwitch) {
        layoutManager.showXHeight = sender.on
        updateView()
    }
    @IBAction func ascenderSwitchValueChanged(sender: UISwitch) {
        layoutManager.showAscender = sender.on
        updateView()
    }
    @IBAction func descenderHeightSwitchValueChanged(sender: UISwitch) {
        layoutManager.showDescender = sender.on
        updateView()
    }
    @IBAction func lineGapHeightSwitchValueChanged(sender: UISwitch) {
        layoutManager.showLineGap = sender.on
        updateView()
    }
    @IBAction func lineLineHeightSwitchValueChanged(sender: UISwitch) {
        layoutManager.showLineHeight = sender.on
        updateView()
    }
    
    func updateView() {
        layoutManager.invalidateDisplayForCharacterRange(NSMakeRange(0, textStorage.length))
    }
}
