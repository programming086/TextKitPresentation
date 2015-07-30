//
//  LeadingViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 21.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class LeadingViewController: TextViewSlideViewController {

    @IBOutlet var sliders: [SliderView]!
    
    var paragraphStyle = NSMutableParagraphStyle()
    override func createAttributedString() -> NSAttributedString {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute : "Times New Roman"])
        let normalFont = UIFont(descriptor: fontDescriptor, size: 180)
        
        let attributes = [NSFontAttributeName : normalFont, NSForegroundColorAttributeName : UIColor.whiteColor(), NSParagraphStyleAttributeName : paragraphStyle.copy()];
        var attributedString = NSMutableAttributedString(string: "yKbnyKbx", attributes: attributes)
        return attributedString
    }
    
    override func setupLayoutManager() {
        layoutManager.showBaseline = true
        layoutManager.showBoundingRect = true
    }
    
    @IBAction func usesFontLeadingValueChanged(sender: UISwitch) {
        layoutManager.usesFontLeading = sender.on
        layoutManager.invalidateLayoutForCharacterRange(NSMakeRange(0, textStorage.length), actualCharacterRange: nil)
    }
    
    @IBAction func baselineValueChanged(sender: UISlider) {
        textStorage.addAttribute(NSBaselineOffsetAttributeName, value: sender.value, range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func lineSpacingChanged(sender: UISlider) {
        paragraphStyle.lineSpacing = CGFloat(sender.value)
        textStorage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle.copy(), range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func lineHeightMultipleChanged(sender: UISlider) {
        paragraphStyle.lineHeightMultiple = CGFloat(sender.value)
        textStorage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle.copy(), range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func minimumLineHeightChanged(sender: UISlider) {
        paragraphStyle.minimumLineHeight = CGFloat(sender.value)
        textStorage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle.copy(), range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func maximumLineHeightChanged(sender: UISlider) {
        paragraphStyle.maximumLineHeight = CGFloat(sender.value)
        textStorage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle.copy(), range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func reset(sender: AnyObject) {
        paragraphStyle = NSMutableParagraphStyle()
        let range = NSMakeRange(0, textStorage.length)
        textStorage.removeAttribute(NSParagraphStyleAttributeName, range: range)
        textStorage.removeAttribute(NSBaselineOffsetAttributeName, range: range)
        
        for (index, sliderView) in enumerate(sliders) {
            sliderView.slider.value = (sliderView.slider.minimumValue + sliderView.slider.maximumValue)/2
            sliderView.valueLabel.text = String(format:"0")
        }
    }
}
