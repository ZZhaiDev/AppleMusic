//
//  ZJPresentationController.swift
//  weiBo
//
//  Created by zijia on 2016/11/23.
//  Copyright © 2016年 zijia. All rights reserved.
//

import UIKit

class ZJPresentationWhileNavigationController: UIPresentationController {
    
    fileprivate lazy var coverView = UIView()
    
    
    //  在containerViewWillLayoutSubviews中 设置弹出view的尺寸
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        // 设置弹出view的尺寸
        presentedView?.frame = CGRect(x: 0 , y: h - 190, width:w , height:200)

        presentedView?.layer.masksToBounds = true
        presentedView?.layer.cornerRadius = 20
        
        // 添加蒙版
        setupCoverView()
    }

   
}

extension ZJPresentationWhileNavigationController{
    fileprivate func setupCoverView(){
        
        // set coverView color and frame
        containerView?.insertSubview(coverView, at: 0)
//        coverView.backgroundColor = UIColor(displayP3Red: 37/255.0, green: 38/255.0, blue: 48/255.0, alpha: 1)
        coverView.backgroundColor = UIColor(white: 0.9, alpha: 0.3)
//        coverView.backgroundColor = UIColor.clear
//        coverView.backgroundColor = UIColor.clear
        coverView.frame = (containerView?.bounds)!
        
        // 添加手势
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

extension ZJPresentationWhileNavigationController{
    @objc fileprivate func coverViewClick(){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
