//
//  File.swift
//  
//
//  Created by Hassan Riaz on 21/12/2022.
//

import Foundation

public enum ExceptionType: Int {
    case danger
    case info
    case customView
    case success
    case warning
}


public enum ServiceResponseError: Error {
    case generalException(message:String,exceptionType:ExceptionType = .danger)
    case sessionExpire(message:String)
}

public class ServerErrorHandler {
    
    static func checkErrorMessage(error: Error? = nil,message:String? = nil) -> ServiceResponseError {
        let errorMessage = "Server Error, Please Try Again"
                
        return ServiceResponseError.generalException(message: errorMessage,exceptionType: .danger)
    }
}

class ResponseMessage {
    enum messages:String {
        case missingURL = "URL is missing"
        case sessionDeinitialized = "Session Deinitialized"
        case internetOffline = "Internet Connection appears to be offline \n Please check your Network"
        case inputSerializationFailed = "Please Check your input data"
    }
}

struct CustomError : Error {
    let description : String
    let message : String
    let code : Int
    var localizedDescription: String {
        return NSLocalizedString(description, comment: "")
    }
}

class CustomErrorCase {
    enum ErrorCase {
        
    }
}


