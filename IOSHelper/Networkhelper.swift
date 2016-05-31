//
//  NetworkHelper.swift
//  IOSHelper
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 egg. All rights reserved.
//

import Foundation

import SystemConfiguration.CaptiveNetwork

class NetworkHelper: NSObject {
    //获取 WiFi 信息
    class func getWifiInfo() -> (ssid: String, mac: String) {
        if let cfas: NSArray = CNCopySupportedInterfaces() {
            for cfa in cfas {
                if let dict = CFBridgingRetain(
                    CNCopyCurrentNetworkInfo(cfa as! CFString)
                    ) {
                    print("dict:\(dict)")
                    if let ssid = dict["SSID"] as? String,
                        let bssid = dict["BSSID"] as? String {
                        return (ssid, bssid)
                    }
                }
            }
        }
        return ("未知", "未知")
    }
}