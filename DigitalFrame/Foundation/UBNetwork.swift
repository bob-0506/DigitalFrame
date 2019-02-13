//
//  UBNetwork.swift
//  DigitalFrame
//
//  Created by bob on 08/02/2019.
//  Copyright © 2019 uncle bob. All rights reserved.
//

import Foundation
import Alamofire
import XMLMapper

class UBNetwork: NSObject {
    
    static public var configuration: UBNetwork.Configutaion = UBNetwork.Configutaion()

    @discardableResult
    class func request<T: XMLBaseMappable>(_ url: URLConvertible, parameters: [String: Any]?, responseHandler: @escaping (UBNetwork.Response<T>) -> Void) -> DataRequest? {
        guard let url = try? url.asURL() else {
            return nil
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: configuration.timeout)
        
        return Alamofire.request(urlRequest)
            .validate(statusCode: 200..<300)
            .responseXMLObject { (response: DataResponse<T>) in
            let res = UBNetwork.Response(statusCode: response.response?.statusCode, data: response.result.value)
                responseHandler(res)
        }
    }
    
    class func downloadImage(_ url: URLConvertible, handler: ((UIImage?) -> Void)?) {
        
        guard let url = try? url.asURL() else {
            handler?(nil)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30.0)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            if let cachedImage = UIImage(data: cachedResponse.data) {
                print("cached")
                handler?(cachedImage)
                return
            }
        }
        
        let conf =  URLSessionConfiguration.default
        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main);
        session.dataTask(with: request) { (data, resp, err) in
            guard data != nil, resp != nil else {
                handler?(nil)
                return
            }
            
            guard let networkImage = UIImage(data: data!) else {
                handler?(nil)
                return
            }
            
            handler?(networkImage)
            
            }.resume()
    }
    
}

extension UBNetwork {
    struct Configutaion {
        public var timeout: TimeInterval = 20.0
        public var debugable: Bool = true
    }
    
    struct Response<T: XMLBaseMappable> {
        let statusCode: Int!
        let data: T?
    }
}
