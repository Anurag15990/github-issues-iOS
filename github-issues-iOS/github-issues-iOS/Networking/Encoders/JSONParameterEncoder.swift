//
//  JSONParameterEncoder.swift
//  github-issues-iOS
//
//  Created by Anurag on 07/01/21.
//

import Foundation

/*
 MARK: Entity to perform encoding based on JSON Parameters.
 */
public struct JSONParameterEncoder: ParameterEncoder {
    
    /*
     MARK: Method to perform JSON Encoding with given set of parameters and request.
     */
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters?, with bData: BodyData? = nil) throws {
        do {
            if let bodyData = bData {
                urlRequest.httpBody = bodyData
            }
            else {
                let bodyData = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
                urlRequest.httpBody = bodyData
            }
            if let content = String(data: urlRequest.httpBody!, encoding: .utf8) {
                debugPrint("------------------------------------------------------")
                debugPrint("URL : \(urlRequest.url?.absoluteString ?? "No URL")")
                debugPrint("Header : \(urlRequest.allHTTPHeaderFields ?? ["No Key": "No Value"])")
                debugPrint("Body : \(content)")
                debugPrint("------------------------------------------------------")
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw ApiError.encodingFailed
        }
    }
}
