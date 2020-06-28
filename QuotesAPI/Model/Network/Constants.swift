////
//Constants.swift
//QuotesAPI
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://programming-quotes-api.herokuapp.com"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
