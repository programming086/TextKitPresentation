//
//  TextStorageExampleViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 19.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextStorageExampleViewController: SlideViewController, UITextViewDelegate {

    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var sourceView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextKitStack()
    }
    
    func setupTextKitStack() {
        // Создаем NSTextStorage
        let textStorage = TextStorage()
        textStorage.setAttributedString(createAttributedString())

        // Создаем NSLayoutManager и добавляем его в NSTextStorage
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // Создаем NSTextContainer и добавляем его в NSLayoutManager
        let textContainer = NSTextContainer(size: textViewContainer.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        // Создаем UITextView c заданным NSTextContainer
        let textView = UITextView(frame: textViewContainer.bounds, textContainer: textContainer)
        textView.backgroundColor = UIColor.clearColor()
        textViewContainer.addSubview(textView)
    }
    
    func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont(name: "Georgia", size: 55)
        let attributes = [
            NSFontAttributeName : normalFont!,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
        ];
        let text = "Rambler&Co — одна из крупнейших в России групп компаний, работающих в области медиа, технологий и электронной коммерции. Холдинг образовался в 2013 году в результате объединения активов «Афиша-Рамблер» (интернет-холдинг «Рамблер», «Афиша», «Лента.ру», «Бегун», «Прайс-экспресс» и «Рамблер-Игры») и SUP Media («Газета.ru», LiveJournal.com, «Чемпионат.com» и другие)."
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.textViewContainer.alpha = 1 - self.textViewContainer.alpha
            self.sourceView.alpha = 1 - self.sourceView.alpha
        })
    }
}
