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
