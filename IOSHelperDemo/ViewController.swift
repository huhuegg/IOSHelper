//
//  ViewController.swift
//  IOSHelperDemo
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 egg. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarManager.instance.initNavigationBarStyle(self, tintColor: UIColor.blackColor(), titleColor: UIColor.whiteColor(), statusBarStyle: UIStatusBarStyle.LightContent, show:true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let (majorVersion,minorVersion) = DeviceHelper.systemVersion()
        print("version:\(majorVersion).\(minorVersion)")
        
        if DeviceHelper.isAboveVersion(8, minMinorVersion: 3) {
            print("above 8.3")
        }
        
        let(ssid,mac) = NetworkHelper.getWifiInfo()
        print("ssid:\(ssid) mac:\(mac)")
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.grayColor()
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("y:\(scrollView.contentOffset.y)")
        NavigationBarManager.instance.changeNavigationBar(scrollView, toTintColor: UIColor.whiteColor(), toTitleColor: UIColor.blackColor(), toStatusBarStyle: UIStatusBarStyle.Default)
    }
    

}

