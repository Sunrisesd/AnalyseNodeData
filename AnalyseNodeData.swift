//
//  AnalyseNodeData.swift
//  AnsoLargeUser
//
//  Created by Sunrise on 2019/4/30.
//  Copyright © 2019 Sunrise. All rights reserved.
//
// 用于解析二叉树数据

import UIKit

class AnalyseNodeData: NSObject {
    
    private let dataSource = NSMutableArray.init()
    private var childSum = 0
    private var parentSum = 0
    
    // 解析基础资料列表数据
    func analyseInitData(_ dataArray:[String]) -> NSMutableArray {
        
        self.dataSource.removeAllObjects()
        childSum = 0
        parentSum = 0
        
        let dataArrM = NSMutableArray.init()
        let modelArrM = NSMutableArray.init()
        let dict = NSMutableDictionary.init()
        
        for i in 0..<dataArray.count-1 {
            
            let valueArray = dataArray[i].components(separatedBy: "|")
            
            if valueArray.count <= 8 {
                continue
            }
            
            let node = AnsoNodeModel.init()
            node.childrenId = valueArray[0]
            node.parentID = valueArray[1]
            node.nodeName = valueArray[2]
            node.dataArrM = NSMutableArray.init()
            node.deviceNumber = valueArray[0]
            node.deviceCaliber = valueArray[3]
            node.deviceCard = valueArray[7]
            node.userNumber = valueArray[8]
            node.userName = valueArray[2]
            node.userSite = valueArray[6]
            node.meterDataType = valueArray[4]
            node.uPid = valueArray[5]
            node.expand = false
            node.root = false
            
            if valueArray[4] == "组织" {
                
                node.leaf = false
                
            }else {
                
                node.leaf = true
            }
            
            modelArrM.add(node)
            
            dict.setValue(node, forKey: node.childrenId!)
        }
        
        for i in 0..<modelArrM.count {
            
            let model = modelArrM[i] as! AnsoNodeModel
            let pid = model.parentID!
            
            if pid == "" {
                
                model.level = 1
                model.root = true
                model.expand = true
                dataArrM.add(model)
                
            }else {
                
                if dict.object(forKey: pid) != nil {
                    
                    let node = dict.object(forKey: pid) as! AnsoNodeModel
                    
                    if node.level == nil {
                        
                        node.level = self.getParentModelLevel(node.parentID!, dict)+1
                    }
                    
                    model.level = node.level!+1
                    node.dataArrM?.add(model)
                }
            }
        }
        
        for i in 0..<dataArrM.count {
            
            let node = dataArrM[i] as! AnsoNodeModel
            
            if node.parentID == "" {
                
                self.dataSource.add(node)
                
                childSum = 0
                
                let _ = self.analyseSource(node.dataArrM!)
                
                node.deviceCount = "\(childSum)"
            }
        }
        
        return self.dataSource
    }
    
    // 确定数据在第几层
    private func getParentModelLevel(_ pid:String, _ dict:NSDictionary) -> Int {
        
        var level = 0
        
        if dict.object(forKey: pid) != nil {
            
            let parentModel = dict.object(forKey: pid) as! AnsoNodeModel
            
            if parentModel.level == nil {
                
                level = self.getParentModelLevel(parentModel.parentID!, dict)+1
                
            }else {
                
                level = parentModel.level!+1
            }
        }
        
        return level
    }
    
    // MARK: 当存在多个区或多个市的时候可能存在bug，待测试
    private func analyseSource(_ dataArray:NSArray) -> Int {
        
        let arrM = NSMutableArray.init(array: dataArray)
        
        var sum = 0
        
        for i in 0..<arrM.count {
            
            let node = arrM[i] as! AnsoNodeModel
            
            if node.leaf! {
                
                return -2
                
            }else {
                
                self.dataSource.add(node)
                
                let status = self.analyseSource(node.dataArrM!)
                
                if status == -2 {
                    
                    node.expand = false
                    node.deviceCount = "\(node.dataArrM!.count)"
                    childSum += node.dataArrM!.count
                    parentSum += node.dataArrM!.count
                    sum += node.dataArrM!.count
                    
                }else {
                    
                    node.expand = true
                    node.deviceCount = "\(status)"
                    
                    if node.parentID?.count == 3 {
                        
                        node.deviceCount = "\(parentSum)"
                        parentSum = 0
                    }
                }
            }
        }
        
        if arrM.count == 0 {
            
            return -2
        }
        
        return sum
    }
}

class AnsoNodeModel: NSObject {
    
    var parentID:String?        // 父结点ID 即当前结点所属的的父结点ID
    var childrenId:String?      // 子结点ID 即当前结点的ID
    var nodeName:String?        // 结点名字
    var level:Int?              // 结点层级 从1开始
    var leaf:Bool?              // 树叶(Leaf) If YES：此结点下边没有结点咯
    var root:Bool?              // 树根((Root) If YES: parentID = nil
    var expand:Bool?            // 是否展开
    var dataArrM:NSMutableArray?// 子结点下的数据
    var searchDescrib:String?   // 描述文字，用于搜索
    
    // 基础资料
    var deviceCount:String?     // 仪表数量
    var deviceNumber:String?    // 仪表编号
    var deviceCaliber:String?   // 仪表口径
    var deviceCard:String?      // SIM卡号
    var userNumber:String?      // 用户编号
    var userName:String?        // 用户名称
    var userSite:String?        // 用户地址
    var userType:String?        // 用户类型
    var userType_Num:String?    // 用户类型编号
    var waterManager:String?    // 所属水司
    var organization:String?    // 所属组织
    var organization_Num:String?  // 组织编号
    var deviceType:String?      // 仪表类型
    var deviceType_Num:String?  // 仪表类型编号
    var deviceInsertTime:String?// 安装日期
    var measureData:String?     // 测量参数
    var meterDataType:String?   // 测量数据类型
    var uPid:String?            // 用于查找数据详情
    var dataSource:String?      // 数据源（APP/..）
    
    // 用户信息
    var provinceName:String?    // 省份名称
    var cityName:String?        // 城市名称
    var compandName:String?     // 公司名称
    var authorCode:String?      // 授权码
    var serviceUrl:String?      // 服务URL
    var longitude:String?       // 经度
    var latitude:String?        // 纬度
    var areaName:String?        // 所属区域
    var cityCode:String?        // 城市编码/区域编码
    var ipSite:String?          // IP地址
    
    // 事件信息
    var eventName:String?       // 事件名称
    var eventTime:String?       // 事件时间
    var eventStatus:String?     // 事件状态
    var eventLevel:String?      // 事件等级
    
    // 用水分析
    var leftName:String?        // 左标题文字描述
    var rightDescrib:String?    // 右边文字描述
    
    // 水表分布
    var flow:String?            // 流量
    var flowDate:String?        // 流量日期
    var pressure:String?        // 压力
    var pressureDate:String?    // 压力日期
    
}
