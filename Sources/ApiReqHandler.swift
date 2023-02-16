

import Foundation
import UIKit
import Alamofire

public struct NFSHTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = NFSHTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = NFSHTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = NFSHTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = NFSHTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = NFSHTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = NFSHTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = NFSHTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = NFSHTTPMethod(rawValue: "PUT")
    /// `QUERY` method.
    public static let query = NFSHTTPMethod(rawValue: "QUERY")
    /// `TRACE` method.
    public static let trace = NFSHTTPMethod(rawValue: "TRACE")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public struct NFSRequest<T:Hashable>:URLRequestConvertible {
    
    private var baseURL: URL {
        return URL(string: APIConstants.baseUrl)!
    }
    
    public var apiPath : String
    public var httpMethod: NFSHTTPMethod
    public var requestModel: [T:Encodable]
    
    public init(apiPath: String, httpMethod: NFSHTTPMethod, requestModel: [T:Encodable]) {
            self.apiPath = apiPath
            self.httpMethod = httpMethod
            self.requestModel = requestModel
//            self.responseModel = responseModel
        }
   

    //Create requestBody
    var requestBody:URLRequest? {
        guard let urlString = baseURL.appendingPathComponent(apiPath).absoluteString.removingPercentEncoding else {
            return nil
        }
        guard let url = URL(string: urlString)  else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        //Set Headers
        for (headerKey, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerKey)
        }
        
        do {
            request = try Alamofire.JSONEncoding.default.encode(request, withJSONObject: requestModel)
        } catch {
            // Handle the error here
            print("An error occurred while encoding the request: \(error)")
        }
        return request
    }
    
    public func asURLRequest() throws -> URLRequest {
        guard let urlRequest = requestBody else {
            fatalError()
        }
        return urlRequest
    }
}

