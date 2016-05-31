//
//  NavigationBarManager.swift
//  IOSHelperDemo
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit


let navigationBarManagerShareInstance:NavigationBarManager = NavigationBarManager()
class NavigationBarManager: NSObject {
    var tintColor:UIColor = UIColor.blackColor()
    var titleColor:UIColor = UIColor.whiteColor()
    var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    
    var controller:UIViewController?
    
    static let instance = {
       return navigationBarManagerShareInstance
    }()
    
    //MARK:- 设置NavigationBar样式
    func initNavigationBarStyle(controller:UIViewController,tintColor:UIColor, titleColor:UIColor, statusBarStyle:UIStatusBarStyle, show:Bool) {
        self.controller = controller
        self.tintColor = tintColor
        self.titleColor = titleColor
        self.statusBarStyle = statusBarStyle
        
        changeStatusBarStyle(statusBarStyle)
        changeTitleColor(titleColor)
        changeBackgroundColor(tintColor)
        
        self.controller?.navigationController?.navigationBar.hidden = !show
    }
    
    
    //MARK:- 设置状态栏样式
    func changeStatusBarStyle(statusBarStyle:UIStatusBarStyle) {
        //动态修改状态栏样式必须在Info.plist中将View controller-based status bar appearance设置为NO
        
        UIApplication.sharedApplication().setStatusBarStyle(statusBarStyle, animated: false)
        //当某页面已经显示的时候需要动态地更改状态栏样式
        self.controller?.setNeedsStatusBarAppearanceUpdate()
    }

    //MARK:- 修改标题颜色
    func changeTitleColor(titleColor:UIColor) {
        self.controller?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:titleColor]
    }
    
    //MARK:- 修改导航栏背景颜色
    func changeBackgroundColor(tintColor:UIColor) {
        self.controller?.navigationController?.navigationBar.barTintColor = tintColor
    }
    
    //MARK:- 设置NavigationBar透明
    func clearColorNavigationBarBackground() {
        //setBackgroundImage实际是设置ImageView子视图
        self.controller?.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        //导航栏下的细线
        self.controller?.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK:- 动态修改NavigationBar颜色和样式
    func changeNavigationBar(scrollView:UIScrollView, toTintColor:UIColor, toTitleColor:UIColor, toStatusBarStyle:UIStatusBarStyle) {
        
        if let barImageView = self.controller?.navigationController?.navigationBar.subviews.first {
            //-64 to 0
            let y = scrollView.contentOffset.y
            if y >= -64.0 && y <= 0.0 { //在bar高度范围内滚动
                let alpha = y / -64
                barImageView.alpha = alpha
            }
            
            if y >= 0 { //向上滚动超过64
                //barImageView.alpha = 1
                
                changeStatusBarStyle(toStatusBarStyle)
//                changeTitleColor(toTitleColor)
//                changeBackgroundColor(toTintColor)
                
                self.controller?.navigationController?.navigationBar.hidden = true
            
            }
            
            if y <= -64 { //向下滚动超过原位置
                changeStatusBarStyle(statusBarStyle)
                changeTitleColor(titleColor)
                changeBackgroundColor(tintColor)
                self.controller?.navigationController?.navigationBar.hidden = false
            }
        }
    }

}
