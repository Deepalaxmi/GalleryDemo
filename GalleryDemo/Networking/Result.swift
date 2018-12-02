//
//  Result.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(DataResponseError)
}


enum DataResponseError : Error{
    case network
    case encoding
    case decoding
    case apiFailure(String)
    case badResponse
    case other
    
    var reason: String{
        switch self {            
        case .network:
            return "Network connection error."
        case .decoding:
            return "An error occurred while decoding data"
            
        case .apiFailure(let statusMessage):
            return statusMessage
        case .encoding:
            return "An error occurred while encoding data"
        case .other:
            return "Error occured"
        case .badResponse:
            return "Bad response"
        }
    }
}
