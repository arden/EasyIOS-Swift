//
//  EUI+TableViewProperty.swift
//  medical
//
//  Created by zhuchao on 15/5/2.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation
import Bond

class TableViewProperty:ScrollViewProperty{
    var tableViewStyle = UITableViewStyle.Plain
    var separatorInset:UIEdgeInsets?
    var rowHeight = UITableViewAutomaticDimension
    
    var reuseCell = Dictionary<String,ViewProperty>()
    var separatorStyle = UITableViewCellSeparatorStyle.SingleLine

    override func view() -> UITableView{
        var view = UITableView(frame: CGRectZero, style: self.tableViewStyle)
        view.tagProperty = self
        view.rowHeight = self.rowHeight
        view.separatorStyle = self.separatorStyle;
        
        if let inset = self.separatorInset {
            view.separatorInset = inset;
        }

        self.renderViewStyle(view)
        for (reuseId,cell) in self.reuseCell {
            view.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        }
        return view
    }
    

    override func renderTag(pelement:OGElement){
        self.tagOut += ["table-view-style","separator-inset","delegate","datasource","row-height","separator-style"]
        
        if let style = EUIParse.string(pelement,key:"table-view-style") {
            if style == "plain" {
                self.tableViewStyle = .Plain
            }else if style == "grouped" {
                self.tableViewStyle = .Grouped
            }
        }

        if let rowHeight = EUIParse.string(pelement, key: "row-height") {
            self.rowHeight = rowHeight.floatValue
        }
        
        if let separatorInset = EUIParse.string(pelement,key:"separator-inset") {
            self.separatorInset = UIEdgeInsetsFromString(separatorInset)
        }
        
        if let separatorStyle = EUIParse.string(pelement, key: "separator-style") {
            switch separatorStyle{
            case "None" :
                self.separatorStyle = .None
            case "SingleLine":
                self.separatorStyle = .SingleLine
            case "SingleLineEtched":
                self.separatorStyle = .SingleLineEtched
            default:
                self.separatorStyle = .SingleLine
            }
        }
        super.renderTag(pelement)
    }
    
    override func childLoop(pelement: OGElement) {
        for element in pelement.children {
            if element.isKindOfClass(OGElement) {
                var ele = element as! OGElement
                var type = EUIParse.string(ele, key: "type")
                var reuseId = EUIParse.string(ele, key: "reuseid")
                if type?.lowercaseString == "cell" && reuseId != nil {
                    self.reuseCell[reuseId!] = EUIParse.loopElement(ele)
                }
            }
        }
    }
    
}