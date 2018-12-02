//
//  Endpoint.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String {get}
    var path: String {get}
    var urlParameters: [URLQueryItem] {get}
}

extension Endpoint{
    var urlComponent: URLComponents{
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters
        return urlComponent!
    }
    
    var request: URLRequest{
        return URLRequest(url: urlComponent.url!)
    }
}
