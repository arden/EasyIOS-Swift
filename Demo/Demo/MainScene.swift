//
//  MainScene.swift
//  Demo
//
//  Created by zhuchao on 15/5/13.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import Foundation

import Bond
import EasyIOS

class MainScene: EUScene,UITableViewDelegate{
    var sceneModel = MainSceneModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EasyIOS"

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func eu_tableViewDidLoad(tableView:UITableView?){
        tableView?.delegate = self
        self.sceneModel.dataArray.map { (data:MainCellViewModel) -> UITableViewCell in
            let cell = tableView!.dequeueReusableCell("cell", target: self,bind:data) as UITableViewCell
            cell.selectionStyle = .None
            return cell
            } ->> self.eu_tableViewDataSource!
    }
    
    func click(){
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var model = self.sceneModel.dataArray[indexPath.row]
        if let link = model.link?.value {
            URLManager.pushURLString(link, animated: true)
        }
    }
}
