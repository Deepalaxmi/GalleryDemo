//
//  PhotoClient.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

class PhotoClient: APIClient {    
    
    static let baseUrl = "https://api.unsplash.com"
    static let apiKey = "d2715ea34530afc18b9f425532cde2b3d9efd17d5a5d9045d06c8b9996b0b26e"

    func fetchPhotos(endpoint: PhotoEndpoint, completion: @escaping (Result<[Photo]>) -> Void){
        let request = endpoint.request
        get(request: request, completion: completion)
    }
    
    
    
}
