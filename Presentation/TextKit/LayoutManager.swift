//
//  LayoutManager.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 19.06.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

/**
@author Irina Dyagileva

LayoutManager, умеющий отображать основные метрики шрифта
*/
class LayoutManager: NSLayoutManager {
 
    var showBaseline = false
    var showBoundingRect = false
    var showMeanline = false
    var showCapHeight = false
    var showXHeight = false
    var showAscender = false
    var showDescender = false
    var showLineGap = false
    var showLineHeight = false
    
    override func drawUnderlineForGlyphRange(glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
       
        // Левая и правая X соордината фрагмента строки
        let firstPointX =  CGRectGetMinX(lineRect)
        let secondPointX =  CGRectGetMaxX(lineRect)

        // Y координата линии шрифта
        let baselineOriginY = ceil(containerOrigin.y + CGRectGetMaxY(lineRect) - baselineOffset)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 2.0)

        // Достаем шрифт из атрибута первого символа
        if let glyphFont = textStorage?.attribute(NSFontAttributeName, atIndex: glyphRange.location, effectiveRange: nil) as? UIFont {
            
            if showAscender {
                UIColor(hex: 0x8C78A4).set()
                let ascenderRect = CGRectMake(firstPointX, lineRect.origin.y, lineRect.width, glyphFont.ascender)
                CGContextFillRect(context, ascenderRect)
            }

            if showDescender {
                UIColor(hex: 0x88C288).set()
                let descenderRect = CGRectMake(firstPointX, baselineOriginY, lineRect.width, -glyphFont.descender)
                CGContextFillRect(context, descenderRect)
            }
            
            if showCapHeight {
                UIColor(hex: 0xF3ABAB).set()
                let originY = baselineOriginY - glyphFont.capHeight
                let capHeightRect = CGRectMake(firstPointX, originY, lineRect.width, glyphFont.capHeight)
                CGContextFillRect(context, capHeightRect)
            }
            
            if showXHeight {
                let xHeightOriginY = baselineOriginY - glyphFont.xHeight
                UIColor(hex: 0xF3E0AB).set()
                let xHeightRect = CGRectMake(firstPointX, xHeightOriginY, lineRect.width, glyphFont.xHeight)
                CGContextFillRect(context, xHeightRect)
            }
            
            if showMeanline {
                let xHeightOriginY = baselineOriginY - glyphFont.xHeight
                UIColor(hex: 0x2149FF).set()
                CGContextMoveToPoint(context, firstPointX, xHeightOriginY)
                CGContextAddLineToPoint(context,secondPointX, xHeightOriginY)
                CGContextStrokePath(context)
            }
            
            if showLineGap {
                let height = lineRect.height - glyphFont.lineHeight;
                let originY = containerOrigin.y + CGRectGetMaxY(lineRect) - height
                UIColor(hex: 0x66A6DB).set()
                let leadingRect = CGRectMake(firstPointX, originY, lineRect.width, height)
                CGContextFillRect(context, leadingRect)
            }
           
            if showLineHeight {
                UIColor.lightGrayColor().set()
                let ascenderRect = CGRectMake(firstPointX, lineRect.origin.y, lineRect.width, glyphFont.lineHeight)
                CGContextFillRect(context, ascenderRect)
            }
        }
        
        if showBaseline {
            UIColor.redColor().set()
            CGContextMoveToPoint(context, firstPointX, baselineOriginY)
            CGContextAddLineToPoint(context,secondPointX, baselineOriginY)
            CGContextStrokePath(context)
        }
        
        CGContextRestoreGState(context)
        
        super.drawUnderlineForGlyphRange(glyphRange, underlineType: underlineVal, baselineOffset: baselineOffset, lineFragmentRect: lineRect, lineFragmentGlyphRange: lineGlyphRange, containerOrigin: containerOrigin)
    }
    
    override func drawGlyphsForGlyphRange(glyphRange: NSRange, atPoint origin: CGPoint) {
        let context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context)
        
        // Дополнительно вызываем метод для отрисовки подчеркивания, так как там происходит отрисовка метрик шрифта
        self.enumerateLineFragmentsForGlyphRange(glyphRange, usingBlock: { (rect, usedRect, textContainer, glyphRange, stop) -> Void in
            self.underlineGlyphRange(glyphRange, underlineType: NSUnderlineStyle.StyleNone, lineFragmentRect:usedRect, lineFragmentGlyphRange: glyphRange, containerOrigin:origin)
        })
        
        //Пробегаемся по всем символам и отрисовываем boundingRect для каждого
        if showBoundingRect {
            for i in glyphRange.location ..< NSMaxRange(glyphRange) {
                
                if let textContainer = self.textContainerForGlyphAtIndex(i, effectiveRange: nil) {
                    var glyphRect = self.boundingRectForGlyphRange(NSMakeRange(i, 1), inTextContainer:textContainer)
                    glyphRect.origin.x += origin.x;
                    glyphRect.origin.y += origin.y;
                    glyphRect = CGRectInset(CGRectIntegral(glyphRect), 0.5, 0.5);
                    
                    UIColor.cyanColor().set()
                    UIBezierPath(rect: glyphRect).stroke()
                }
            }
        }

        CGContextRestoreGState(context)
        super.drawGlyphsForGlyphRange(glyphRange, atPoint: origin)
    }
}

    