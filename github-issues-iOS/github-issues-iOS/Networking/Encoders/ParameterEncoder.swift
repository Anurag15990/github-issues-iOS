//
//  ParameterEncoder.swift
//  github-issues-iOS
//
//  Created by Anurag on 07/01/21.
//

import Foundation

/*
 MARK: Protocol for support of different types of encodings allowed in the app. All Encoders should confirm to the ParameterEncoder Protocol.
 */
public protocol ParameterEncoder {
//    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters?, with bData: BodyData?) throws
}
