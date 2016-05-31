//
//  DeviceHelper.swift
//  IOSHelper
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 egg. All rights reserved.
//

import Foundation
import SystemConfiguration


class DeviceHelper:NSObject {
    
    //系统版本
    class func systemVersion()->(majorVersion:Int, minorVersion:Int) {
        if #available(iOS 8.0, *) {
            let os = NSProcessInfo().operatingSystemVersion
            return (os.majorVersion, os.minorVersion)
        }
        //TODO 添加8.0以下的支持
        return(0,0)
    }
    
    //判断是否满足指定的最低系统版本要求
    class func isAboveVersion(minMajorVersion:Int, minMinorVersion:Int)->Bool {
        let (majorVersion,minorVersion) = self.systemVersion()
        if majorVersion >= minMajorVersion {
            if minorVersion >= minMinorVersion {
                return true
            }
        }
        return false
    }
}