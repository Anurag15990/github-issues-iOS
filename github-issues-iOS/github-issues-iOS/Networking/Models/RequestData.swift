//
//  RequestData.swift
//  github-issues-iOS
//
//  Created by Anurag on 07/01/21.
//

import Foundation

/*
 MARK: Data Structure for construction required data for Network Request.
 - path: URL Endpoint for the request.
 - method: Method to be applied for the request.
 - params: Parameters to be sent along with the request. Can be either Request Parameters or HttpBody.
 - headers: Header parameters to be sent along with the request.
 */

public struct RequestData<T> {
    
    public let path: String
    public let method: HTTPMethod
    public let params: Parameters?
    public let bodyData: BodyData?
    public let headers: Headers?
    public let encodingType: EncodingType
 
    public init(_ path: String,
                method: HTTPMethod = .post,
                params: Parameters? = nil,
                bodyData: BodyData? = nil,
                headers: Headers? = nil,
                encodingType: EncodingType = .jsonEncoding) {
        
        self.path = path
        self.method = method
        self.params = params
        self.bodyData = bodyData
        self.headers = headers
        self.encodingType = encodingType        
    }
}
