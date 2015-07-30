//
//  TextStorage.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 13.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

/**
@author Irina Dyagileva

TextStorage, подменяющий & в подстроке Rambler&Co на картинку
*/
class TextStorage: NSTextStorage {
    var innerAttributedString = NSMutableAttributedString()

    override var string: String {
        return innerAttributedString.string
    }
   
    override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [NSObject : AnyObject] {
        return innerAttributedString.attributesAtIndex(location, effectiveRange: range)
    }
    
    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        beginEditing()
        innerAttributedString.replaceCharactersInRange(range, withString:str)
        edited(.EditedCharacters | .EditedAttributes, range: range, changeInLength: count(str) - range.length)
        endEditing()
    }
    
    override func setAttributes(attrs: [NSObject : AnyObject]!, range: NSRange) {
        beginEditing()
        innerAttributedString.setAttributes(attrs, range: range)
        edited(.EditedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    override func processEditing() {
        var extendedRange = NSUnionRange(self.editedRange, NSString(string: innerAttributedString.string).lineRangeForRange(NSMakeRange(self.editedRange.location, 0)))
        extendedRange = NSUnionRange(self.editedRange, NSString(string: innerAttributedString.string).lineRangeForRange(NSMakeRange(NSMaxRange(self.editedRange), 0)))
        
        let regex = NSRegularExpression(pattern: "(Rambler&Co)", options: nil, error: nil)!
        regex.enumerateMatchesInString(innerAttributedString.string, options: nil, range: extendedRange) {
            match, flags, stop in
            let matchRange = match.rangeAtIndex(1)
            
            var attachment = NSTextAttachment()
            attachment.image = UIImage(named: "rlogo")
            
            self.innerAttributedString.replaceCharactersInRange(NSMakeRange(matchRange.location + 7, 1) , withAttributedString: NSAttributedString(attachment: attachment))
        }

        super.processEditing()
    }
}

