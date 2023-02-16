//
//  ServiceCall.swift
//  
//
//  Created by HASSAN RIAZ on 16/02/2023.
//

import Alamofire

public class ServiceCall {
    public static func Request<T: Decodable>(url: URLRequestConvertible, model: T.Type, completionHandler: @escaping((T?,Error?)->()))
    {
        AF.request(url).responseDecodable(of: model.self){ (response) in
            if let headersDic = response.response?.allHeaderFields {
                for key in NetworkManager.sharedInstance.allHeadersKeys {
                    if let data = headersDic[key] as? String {
                        NetworkManager.sharedInstance.headersData[key] = data
                        print("\(key)=====\(data)")
                    }
                }
               headers  = NetworkManager.sharedInstance.headersData

            }
            print(response)
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value,nil)
            case .failure(let error):
                print(error)
                completionHandler(nil,response.error)
            }
        }
    }
}

