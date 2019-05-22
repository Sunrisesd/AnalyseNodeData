//
//  WRSHelpClass.swift
//  
//
//  Created by sunrise on 2019/5/22.
//  Copyright © 2019年 sunrise. All rights reserved.
//

/*
 * 一些常用数据的格式判断
 */

import UIKit

class WRSHelpClass: NSObject {
    
    static let shareInstance:HelpClass = {
       
        let help = WRSHelpClass()
        
        return help
    }()
    
    //手机号码判断
    func judgePhoneNum(_ phoneStr:String) -> Bool {
        
        //移动号码段正则表达式
        let CM_NUM = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$"
        
        //联通号码段正则表达式
        let CU_NUM = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$"
        
        //电信号码段正则表达式
        let CT_NUM = "^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$"
        
        let pred1:NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", CM_NUM)
        let isMatch1:Bool = pred1.evaluate(with: phoneStr)
        
        let pred2:NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", CU_NUM)
        let isMatch2:Bool = pred2.evaluate(with: phoneStr)
        
        let pred3:NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", CT_NUM)
        let isMatch3:Bool = pred3.evaluate(with: phoneStr)
        
        if isMatch1||isMatch2||isMatch3 {
            
            return true
        }
        
        return false
    }
    
    //邮箱判断
    func judgeEmail(_ emailStr:String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailPredicate = NSPredicate.init(format: "SELF MATCHES %@", emailRegex)
        
        let isMatch = emailPredicate.evaluate(with: emailStr)
        
        return isMatch
    }
    
    //身份证判断
    func judgeCard(_ cardStr:String) -> Bool {
        
        let cardRedex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        
        let cardPredicate = NSPredicate.init(format: "SELF MATCHES %@", cardRedex)
        
        let isMatch = cardPredicate.evaluate(with: cardStr)
        
        return isMatch
    }
    
    //纯数字判断
    func judgeNumber(_ numberStr:String) -> Bool {
        
        let numberRedex = "^[0-9]+$"
        
        let numberPredicate = NSPredicate.init(format: "SELF MATCHES %@", numberRedex)
        
        let isMatch = numberPredicate.evaluate(with: numberStr)
        
        return isMatch
    }
    
    //数字、字母与符号的判断
    func numberAndAlphabetAndSymbol(_ passWordStr:String) -> Bool {
        
        let passWordRedex = "[a-zA-Z0-9]+$|[^a-zA-Z0-9/D]+$"
        
        let passWordPredicate = NSPredicate.init(format: "SELF MATCHES %@", passWordRedex)
        
        let isMatch = passWordPredicate.evaluate(with: passWordStr)
        
        return isMatch
    }

    //判断字符串中是否同时包含数字和字母
    func judgePassWordLegal(_ passWordStr:String) -> Bool {
        
        //判断长度大于6位且少于16位后再接着判断是否同时包含数字和字符
        let passWordRedex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"
        
        let passWordPredicate = NSPredicate.init(format: "SELF MATCHES %@", passWordRedex)
        
        let isMatch = passWordPredicate.evaluate(with: passWordStr)
        
        return isMatch
    }
}
