//
//  TextContainerExampleViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 20.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextContainerExampleViewController: SlideViewController {

    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var sourceView: UITextView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepperView: UIView!
    
    let textStorage = NSTextStorage()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextKitStack()
    }
    
    func setupTextKitStack() {
        // Создаем NSTextStorage
        textStorage.setAttributedString(createAttributedString())
        
        // Создаем NSLayoutManager и добавляем его в NSTextStorage
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // Создаем NSTextContainer и добавляем его в NSLayoutManager
        let textContainer = TextContainer(size: textViewContainer.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        // Создаем UITextView c заданным NSTextContainer
        let textView = UITextView(frame: textViewContainer.bounds, textContainer: textContainer)
        textView.backgroundColor = UIColor.clearColor()
        textView.editable = false;
        textViewContainer.addSubview(textView)
    }
    
    func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont.systemFontOfSize(30.0)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        let attributes = [
            NSFontAttributeName : normalFont,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSParagraphStyleAttributeName: paragraphStyle.copy()
        ];
        let text = "Компания RCO, специализирующаяся на компьютерной лингвистике, информационном поиске и обработке неструктурированной информации, вошла в группу компаний Rambler&Co. Об этом «Ленте.ру» сообщила PR-директор холдинга София Иванова. RCO разрабатывает программное обеспечение для «интеллектуальной» обработки текстов преимущественно на русском языке. Продукты компании позволяют извлекать из источников фактографическую информацию вроде упоминаний организаций, персон, географических объектов, брендов, событий с указанием участников и их ролей, а также категоризировать большие массивы текстов, объединять похожие по смыслу документы в сюжеты. Список партнеров и заказчиков компании составляют крупные корпорации и государственные структуры. «Мы видим большой потенциал для решения бизнес-задач группы компаний Rambler&Co. В первую очередь, в области совмещения технологий интеллектуального контент-анализа и рекламных технологий», — прокомментировал Максим Тадевосян, заместитель генерального директора Rambler&Co. Кроме того, по его словам, RCO поспособствуют выводу на рынок нового продукта для сбора в одном месте аналитики из разных цифровых СМИ и реакции пользователей на различные инфоповоды. В свою очередь для RCO — это выход за рамки корпоративного сектора и возможность применить разработки и опыт компании в сегменте публичных информационных сервисов и СМИ. «Объем обрабатываемых [в этой области] данных больше на порядки, сложность решаемых задач значительно выше», — отметил генеральный директор RCO Владимир Плешко.Rambler&Co — одна из крупнейших российских групп компаний в области медиа, технологий и электронной коммерции. По данным Rambler&Co, аудитория интернет-холдинга превышает 36 миллионов человек в месяц. В холдинг в 2013 году объединены активы «Афиши-Рамблера» (ООО «Рамблер Интернет Холдинг», ООО «Компания Афиша», ООО «Лента», ООО «Прайс-экспресс», ЗАО «Бегун», ООО «Рамблер-Игры») и SUP Media («Газета.ru», LiveJournal.com, «Чемпионат.com» и другие). С апреля 2014-го компания работает под единым брендом Rambler&Co. Председателем совета директоров и руководителем Rambler&Co является Александр Мамут."
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.textViewContainer.alpha = 1 - self.textViewContainer.alpha
            self.stepperView.alpha = self.textViewContainer.alpha
            self.sourceView.alpha = 1 - self.sourceView.alpha
        })
    }

    @IBAction func fontSizeValueChanged(sender: UIStepper) {
        valueLabel.text = String(format:"%.1f", sender.value)
        let font = UIFont.systemFontOfSize(CGFloat(sender.value))
        textStorage.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, textStorage.length))
    }

}
