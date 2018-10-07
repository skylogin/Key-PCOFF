//
//  KeyCompute.swift
//  Key-PCOFF
//
//  Created by Awesome S on 01/10/2018.
//  Copyright © 2018 Awesome S. All rights reserved.
//

import Foundation
import CryptoSwift

class KeyBrain{
    var DEFAULT_ID = "A"
    var DELETE_ID = "B"
    var USE_ID = "C"
    
    private var selectDate = Date()

    
    func setDate(date: Date){
        selectDate = date
    }
    
    var getDate: Date{
        get{ return selectDate }
    }
    
    
    func setKey(){
        // 키값 설정
        let path = Bundle.main.path(forResource: "Key", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        let dic = plist as! [String:String]
        
        DEFAULT_ID = dic["DEFAULT_ID"]!
        DELETE_ID = dic["DELETE_ID"]!
        USE_ID = dic["USE_ID"]!
    }
    
    
    func getDeleteKey(now: String) -> String{
        let key = DEFAULT_ID + DELETE_ID + now
        let value = getKey(s: key)
        
        return value
    }
    
    func getUseKey(now: String) -> String{
        let key = DEFAULT_ID + USE_ID + now
        let value = getKey(s: key)
        
        return value
    }
    
    
    private func getKey(s: String) -> String{
        let s1 = getMD5(s: s).uppercased()
        let s2 = getMD5(s: s1).uppercased()
        let s3 = getMD5(s: s2).uppercased()
        let s4 = getMD5(s: s3).uppercased()
        
        
        var result = ""
        var value = ""
        
        var startIndex = s1.index(s1.startIndex, offsetBy: 0)
        var endIndex = s1.index(startIndex, offsetBy: 4)
        value = String(s1[startIndex..<endIndex])
        result += value.reversed()
        
        startIndex = s2.index(s2.startIndex, offsetBy: 4)
        endIndex = s2.index(startIndex, offsetBy: 8)
        value = String(s2[startIndex..<endIndex])
        result += value.reversed()
        
        startIndex = s3.index(s3.startIndex, offsetBy: 8)
        endIndex = s3.index(startIndex, offsetBy: 12)
        value = String(s3[startIndex..<endIndex])
        result += value.reversed()
        
        startIndex = s4.index(s4.startIndex, offsetBy: 12)
        endIndex = s4.index(startIndex, offsetBy: 16)
        value = String(s4[startIndex..<endIndex])
        result += value.reversed()
        
        
        
        value = getMD5(s: result)
        result = String(value.reversed())
        
        startIndex = result.index(result.startIndex, offsetBy: 0)
        endIndex = result.index(startIndex, offsetBy: 6)
        value = String(result[startIndex..<endIndex])
        result = value.uppercased()
        
        return result
    }
    
    private func getMD5(s: String) -> String{
        return s.md5()
    }
    
    
    
}
