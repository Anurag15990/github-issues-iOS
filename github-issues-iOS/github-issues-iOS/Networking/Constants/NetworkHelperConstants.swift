//
//  NetworkHelperConstants.swift
//  github-issues-iOS
//
//  Created by Anurag on 07/01/21.
//

import Foundation

/* ====================================================================
 MARK: HTTP Method Definitions to be used for a particular API Request.
   ==================================================================== */
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

/* =======================================================================================
 MARK: Type of dictionary to be passed as Request body or URL Parameters for a particular
 API Request.
   ======================================================================================= */
public typealias Parameters = [String: Any]

public typealias BodyData = Data

/* =============================================================================
 MARK: Type of dictionary to be passed as Headers for a particular API Request.
   =============================================================================*/
public typealias Headers = [String: String]

/* =============================================================================
 MARK: Encoding type to be used in API Request
   ============================================================================= */
public enum EncodingType {
    case jsonEncoding
    case parameterEncoding
}

/* =============================================================================
 MARK: Error types to be used in API Request
 ============================================================================= */
enum ApiError: Error {
    case urlNotSet
    case encodingFailed
}
