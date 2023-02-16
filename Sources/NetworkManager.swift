//
//  NetworkManager.swift
//  
//
//  Created by HASSAN RIAZ on 16/02/2023.
//

import Foundation

var headers : [String:String] {
    get{
        NetworkManager.sharedInstance.headersData
    }
    set(newValue) {
        NetworkManager.sharedInstance.headersData = newValue
    }
}
public class NetworkManager: NSObject {
    
    lazy var allHeadersKeys: [String] = {

        return APIConstants.headersKey
    }()
    
    lazy var headersData:[String: String] = [:]
    
    static let sharedInstance :NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    private override init() {
        
    }
}
