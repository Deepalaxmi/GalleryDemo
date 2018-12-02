//
//  GalleryViewModel.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryViewModelDelegate: class {
    func onFetchCompleted(with newIndepathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class GalleryViewModel {
    weak var delegate: GalleryViewModelDelegate?
    
    private let client: APIClient
    var photos: [Photo] = []
    var cellViewModel: [CellViewModel] = []
    private var currentpage = 1 //page number, API request pagination is defaulted to 10 items
    private var isFetchInProgress = false //prevents multiple requests happening
    var isCompletePhotoListAvailable = false
    
    
    init(client: APIClient, delegate: GalleryViewModelDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    func fetchPhotoList()  {
        guard let client = client as? PhotoClient else{
            return
        }
        
        guard !isFetchInProgress else{
            return
        }
        
        guard !isCompletePhotoListAvailable else {
            return
        }
        
        isFetchInProgress = true
        
        let photoEndpoint = PhotoEndpoint.photos(id: PhotoClient.apiKey, order: .popular, page: currentpage)
            client.fetchPhotos(endpoint: photoEndpoint) { (result) in
                switch result {
                case .success(let photos):
                    //
                    DispatchQueue.main.async {
                        //increment the page number to retrieve
                        self.currentpage += 1
                        self.isFetchInProgress = false
                        if photos.count > 0{
                            //append the new items to the photo list and inform the delegate that there’s data available
                            self.photos.append(contentsOf: photos)
                            let indexPathToReload = self.calculateIndexPathToReload(from: photos)
                            self.fetchPhoto(indexPathToReload: indexPathToReload)
                        }else{
                            // complete photo list already available no need to hit api again
                            self.isCompletePhotoListAvailable = true
                            self.delegate?.onFetchCompleted(with: .none)
                        }
                    }
                case .failure(let error):
                    //If the request fails, inform the delegate of the reason for that failure and show the user a specific alert
                    print(error)
                    DispatchQueue.main.async {
                        self.isFetchInProgress = false
                        self.delegate?.onFetchFailed(with: error.reason)
                    }
                }
                
            }
        
    }
    
    //calculates the index paths for the last page of photos received from the API, helps to refresh only the content that's changed
    private func calculateIndexPathToReload(from newPhotos: [Photo]) -> [IndexPath]{
        let startIndex = photos.count - newPhotos.count
        let endIndex = startIndex + newPhotos.count
        return (startIndex..<endIndex).map({ IndexPath(row: $0, section: 0)})
    }
    
    
    private func fetchPhoto(indexPathToReload: [IndexPath]) {
        let group = DispatchGroup()
        for indexpath in indexPathToReload{
            let photo = self.photos[indexpath.item]
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                guard let imageData = try? Data(contentsOf: photo.urls.small) else {
                    print("error")
                    return
                }
                
                guard let image = UIImage(data: imageData) else {
                    print("error 2")
                    return
                }
                
                self.cellViewModel.append(CellViewModel(photoImage: image))
                group.leave()
            }

        }
        
        group.notify(queue: .main) {
            self.delegate?.onFetchCompleted(with: indexPathToReload)
        }
    }

    
    
    
}
