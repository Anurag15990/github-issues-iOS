//
//  NetworkManager.swift
//  github-issues-iOS
//
//  Created by Anurag on 07/01/21.
//

import Foundation
import RxSwift
/*
 MARK: Entity to handle all network calls for the application. This is the single point in the application through which all API calls will be made.
 */
class NetworkManager {
    
    static let shared = NetworkManager()
        private init() {
    }
    
    /*
     MARK: Method that will be handle the request creation and performing the api call. It is of Generic Type T which confirms to Codable format and returns a Observable for Generic Type T. In Addition to this, it accepts the Request Data object which contains the configurable parameters for the Request.
     
         All Classes that is calling this function will recieve an event based on completion of Request either with a T object or error message.
     */
    public func request<T: Decodable>(withRequestData requestData: RequestData<T>) -> Observable<T> {
        var task: URLSessionTask?
        
        return Observable<T>.create({ (observer) -> Disposable in
            do {
                
                if let request = try self.buildRequest(fromRequestData: requestData) {
                    task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        
                        if let error = error {
                            observer.onError(error)
                        }
                        
                        if let data = data {
                            debugPrint(String(data: data, encoding: .utf8) ?? "JSON string Faile")
                            do {
                                let response = try JSONDecoder().decode(T.self, from: data)
                                observer.onNext(response)
                            } catch {
                                observer.onError(error)
                            }
                        }
                    })
                    
                    task?.resume()
                }
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create {
                task?.cancel()
            }
        })
    }
    
    /*
     MARK: Method to physically build the URLRequest that will be used to perform the Network Call.
     It takes RequestData parameter that will contain all the configurations for the Request.
     */
    private func buildRequest<T>(fromRequestData requestData: RequestData<T>) throws -> URLRequest? {
        guard let url = URL.init(string: requestData.path) else {
           return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = requestData.method.rawValue
        
        addAdditionalHeaders(requestData.headers, request: &request)
        
        do {
            try configureParameters(requestData.params, bodyData: requestData.bodyData, request: &request, encodingType: requestData.encodingType)
        } catch {
            throw error
        }
        
        return request
    }
    
    /*
     MARK: Method to add Additional Headers to the request.
     */
    private func addAdditionalHeaders(_ headers: Headers?, request: inout URLRequest) {
        guard let headers = headers else {
            return
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    /*
     MARK: Method to configure Request Parameters based on encoding type.
     It accepts parameters object and Encoding type. The Encoding type can either be ParameterEncoding or JSONEncoding.
     */
    private func configureParameters(_ parameters: Parameters?, bodyData bData: BodyData?, request: inout URLRequest, encodingType: EncodingType) throws {
        switch encodingType {
        case .jsonEncoding:
            if parameters != nil || bData != nil {
                try JSONParameterEncoder.encode(urlRequest: &request, with: parameters, with: bData)
            }
        case .parameterEncoding:
            if let parameters = parameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: parameters, with: bData)
            }
        }
    }
}
