//
//  EUI+CollectionViewProperty.swift
//  medical
//
//  Created by zhuchao on 15/5/10.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import Bond

class CollectionViewProperty: ScrollViewProperty {
    var separatorInset:UIEdgeInsets?
    var reuseCell = Dictionary<String,ViewProperty>()
    var flowLayout = Dictionary<String,String>()
    var layout:String?
    
    override func view() -> UICollectionView{
        var view = UICollectionView(frame: CGRectZero, collectionViewLayout: self.getLayout())
        view.tagProperty = self
        
        self.renderViewStyle(view)
        for (reuseId,cell) in self.reuseCell {
            view.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseId)
        }
        return view
    }
    
    override func renderTag(pelement:OGElement){
        self.tagOut += ["delegate","datasource","flow-layout","layout"]
        
        if let layout = EUIParse.string(pelement, key: "flow-layout") {
            var dict = layout.trimArrayBy(";")
            for value in dict {
                var array = value.trimArrayBy(":")
                var key = array[0] as String
                var val = array[1] as String
                self.flowLayout[key.toKeyPath] = val
            }
        }
        
        self.layout = EUIParse.string(pelement, key: "layout")
        
        super.renderTag(pelement)
    }

    func getLayout() -> UICollectionViewLayout{
        if let customlayout = self.layout,let nsobject = NSObject(fromString: customlayout) as? UICollectionViewLayout {
            return nsobject
        }
        
        var layout = UICollectionViewFlowLayout()
        for (key,value) in self.flowLayout{
            if key == "minimumLineSpacing" || key == "minimumInteritemSpacing"{
                layout.setValue(value.anyValue, forKeyPath: key)
            }else if key == "itemSize" {
                layout.itemSize = CGSizeFromString(value)
            }else if key == "estimatedItemSize" {
                layout.estimatedItemSize = CGSizeFromString(value)
            }else if key == "headerReferenceSize" {
                layout.headerReferenceSize = CGSizeFromString(value)
            }else if key == "footerReferenceSize"{
                layout.footerReferenceSize = CGSizeFromString(value)
            }else if key == "sectionInset" {
                layout.sectionInset = UIEdgeInsetsFromString(value)
            }else if key == "scrollDirection" {
                if value.lowercaseString == "Vertical".lowercaseString {
                    layout.scrollDirection = .Vertical
                }else if value.lowercaseString == "Horizontal".lowercaseString {
                    layout.scrollDirection = .Horizontal
                }
            }
        }
        return layout
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
