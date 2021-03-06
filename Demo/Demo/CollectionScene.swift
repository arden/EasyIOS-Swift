//
//  CollectionScene.swift
//  Demo
//
//  Created by zhuchao on 15/5/13.
//  Copyright (c) 2015年 zhuchao. All rights reserved.
//

import UIKit
import EasyIOS
import Bond
import SVProgressHUD

class CollectionScene: EUScene {

    var sceneModel = CollectionSceneModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showBarButton(.LEFT, title: "返回", fontColor: UIColor.greenColor())
        self.sceneModel.req.requestNeedActive.value = true
        
        self.sceneModel.req.state *->> Bond<RequestState>(){
            switch $0 {
            case .Sending :
                SVProgressHUD.show()
            case .Success,.SuccessFromCache :
                SVProgressHUD.dismiss()
            case .Error :
                SVProgressHUD.showErrorWithStatus("数据加载失败")
            default :
                return
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func eu_collectionViewDidLoad(collectionView: UICollectionView?) {
        self.sceneModel.viewModelList.map { (data:CollectionCellViewModel,index:Int) -> UICollectionViewCell in
            return collectionView!.dequeueReusableCell(
                "cell",
                forIndexPath:NSIndexPath(forItem: index, inSection: 0),
                target: self,bind:data) as UICollectionViewCell
            } ->> self.eu_collectionViewDataSource!
    }

    override func leftButtonTouch() {
        URLNavigation.dismissCurrentAnimated(true)
    }
}
