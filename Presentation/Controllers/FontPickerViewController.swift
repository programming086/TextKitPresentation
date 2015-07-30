//
//  FontPickerViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.06.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit
import Foundation

struct FontFamily {
    let familyName: String
    let fonts: [String]
}

class FontPickerViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!

    var filterString = ""
    
    var fontFamilies = [FontFamily]()
    
    func createFontFamilies() -> [FontFamily] {
        var families = [FontFamily]()

        for fontFamilyName in UIFont.familyNames() {
            if let fontFamilyName = fontFamilyName as? String {
        
                var fonts = UIFont.fontNamesForFamilyName(fontFamilyName) as! [String]
                if fonts.count > 0 {
                    families.append(FontFamily(familyName: fontFamilyName, fonts: fonts))
                }
            }
        }
        return families;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontFamilies = createFontFamilies()
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fontFamilies.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fontFamily = fontFamilies[section]
        return fontFamily.fonts.count
    }
   
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  fontFamilies[section].familyName
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let fontFamily = fontFamilies[indexPath.section]
        let fontName = fontFamily.fonts[indexPath.row]
            
        cell.textLabel!.text = fontName
        cell.textLabel!.font = UIFont(name: fontName, size: 25.0)
        cell.backgroundColor = UIColor.blackColor()
        return cell;
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGrayColor();
    }
}
