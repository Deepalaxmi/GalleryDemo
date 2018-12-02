//
//  PhotoEndpoint.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

enum Order: String{
    case latest, oldest,popular
}

enum PhotoEndpoint: Endpoint{
    case photos(id: String,order: Order,page:Int)

    var baseUrl: String{
        return PhotoClient.baseUrl
    }
    
    var path: String{
        switch self {
        case .photos:
             return "/photos"
        }
    }
    
    var urlParameters: [URLQueryItem]{
        switch self {
        case .photos(let id, let order,let page):
            return [
                URLQueryItem(name: "client_id", value: id),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "order_by", value: order.rawValue)
            ]
        }
    }
    
}
