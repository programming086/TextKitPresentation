//
//  TouchView.swift
//  Presentation
//
//  Created by Irina Dyagileva on 23/07/15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class SliderView: UIView {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        slider.userInteractionEnabled = false
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        let panGsture = UIPanGestureRecognizer(target: self, action: "pan:")
        self.addGestureRecognizer(panGsture)
    }
    
    func pan(recognizer:UIPanGestureRecognizer) {
        var point = recognizer.locationInView(self)
        let multiplier = Float(point.x / bounds.size.width)
        let value = slider.minimumValue + multiplier * (slider.maximumValue - slider.minimumValue)

        slider.setValue(value, animated: true)
        slider.sendActionsForControlEvents(.ValueChanged)
    }
    
    func sliderValueChanged(slider: UISlider) {
        valueLabel.text = String(format:"%.1f", slider.value)
    }
}
