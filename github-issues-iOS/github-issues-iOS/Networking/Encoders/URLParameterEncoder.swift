//
//  URLParameterEncoder.swift
//  github-issues-iOS
//
//  Created by Anurag on 07/01/21.
//

import Foundation

/*
 MARK: Entity to perform encoding based on Query Parameters.
 */
public struct URLParameterEncoder: ParameterEncoder {
    /*
     MARK: Method to perform URL Parameter Encoding with given set of parameters and request.
     */
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters?, with bData: BodyData? = nil) throws {
        guard let url = urlRequest.url else { throw ApiError.urlNotSet }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let parameters = parameters, !parameters.isEmpty {
                urlComponents.queryItems = [URLQueryItem]()
                
                for (key, value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
