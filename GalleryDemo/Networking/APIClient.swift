//
//  APIClient.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession {get}
}

extension APIClient{
    var session: URLSession {
        return URLSession.shared
    }
    
    func get<T:Codable>(request: URLRequest, completion: @escaping (Result<[T]>) -> Void){
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else{
                completion(Result.failure(DataResponseError.apiFailure(error?.localizedDescription ?? "API failure")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(Result.failure(DataResponseError.badResponse))
                return
            }
            guard let data = data else{
                completion(Result.failure(DataResponseError.other))
                return
            }
            do{
                let decoder = JSONDecoder()
                let reponseDataObj = try decoder.decode([T].self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(reponseDataObj))
                }
                return

            }catch{
                completion(Result.failure(DataResponseError.decoding))
                return
            }
        }
        task.resume()
        
    }
}
