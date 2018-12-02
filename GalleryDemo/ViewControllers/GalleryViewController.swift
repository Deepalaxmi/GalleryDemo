//
//  GalleryViewController.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 02/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var currentDatetimeLabel: UILabel!
    
    private var viewModel: GalleryViewModel!
    var fullName: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetUp()

    }

    func initialSetUp(){
        self.fullNameLabel.text = fullName
        setUpCurrentTime()
        if let layout = collectionView.collectionViewLayout as? PhotoCollectionViewLayout{
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let imageNibCell = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView.register(imageNibCell, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        loadingIndicatorView.color = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5961579623)
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.startAnimating()
        
        viewModel = GalleryViewModel(client: PhotoClient(), delegate: self)
        viewModel.fetchPhotoList()
    }
    
    func setUpCurrentTime(){
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .current, forMode: .common)
        
    }

    @objc func handleUpdate() {
        self.currentDatetimeLabel.text = getDateString(date: Date())
    }
    
    func  getDateString(date:Date)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: date)
        
    }


}

//MARK: PhotoCollectionViewLayoutDelegate methods
extension GalleryViewController: PhotoCollectionViewLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexpath indexpath: IndexPath) -> CGFloat {
//        print("heightForPhotoAtIndexpath")
        if isLoadingCell(for: indexpath){
            return 50
        }else{
            let image = viewModel.cellViewModel[indexpath.item].photoImage
            let height = image.size.height
            return height
        }
        
    }
    
}

//MARK: UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("viewModel.cellViewModel.count \(viewModel.cellViewModel.count)")
        if viewModel.cellViewModel.count > 0{
            return viewModel.isCompletePhotoListAvailable ? viewModel.cellViewModel.count :viewModel.cellViewModel.count + 1
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("cellForItemAt")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell{

            if isLoadingCell(for: indexPath){
                cell.configure(cellViewModel: .none)
            }else{
                cell.configure(cellViewModel: viewModel.cellViewModel[indexPath.item])
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

//MARK: Prefetching API to determine when to load new pages
extension GalleryViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains( IndexPath(item: viewModel.cellViewModel.count-1, section: 0) ) {
            viewModel.fetchPhotoList()
        }
    }
    
}

//MARK: GalleryViewModelDelegate
extension GalleryViewController: GalleryViewModelDelegate{
    func onFetchCompleted(with newIndepathsToReload: [IndexPath]?) {
        loadingIndicatorView.stopAnimating()
        guard let newIndexPathsToReload = newIndepathsToReload else {
            collectionView.reloadData()
            return
        }
        
        let indexPathsToReload = visibleIndexPathToReload(inetrsecting: newIndexPathsToReload)
        if indexPathsToReload.count > 1 {
            collectionView.reloadItems(at: indexPathsToReload)
        }else{
            //first time reloading , no visible cells yet
             collectionView.reloadData()
        }

    }
    
    func onFetchFailed(with reason: String) {
        debugPrint("onFetchFailed")
        loadingIndicatorView.stopAnimating()
        self.showToast(message: reason, seconds: 2.0)
    }
    
    
}

//MARK: Utility methods
private extension GalleryViewController{
    func isLoadingCell(for indexPath: IndexPath) -> Bool{
        return indexPath.item >= viewModel.cellViewModel.count
    }
    
    //calculates the cells that you need to reload when you receive a new page, to avoid refreshing cells that are not currently visible on the screen
    func visibleIndexPathToReload(inetrsecting indexpaths: [IndexPath]) -> [IndexPath]{
//        print("inetrsecting indexpaths \(indexpaths.count)")
        let indexPathForVisibleRows = collectionView.indexPathsForVisibleItems
//        print("indexPathForVisibleRows \(indexPathForVisibleRows.count)")
        let indexpathIntersection = Set(indexpaths).intersection(indexPathForVisibleRows)
//        print("indexpathIntersection \(indexpathIntersection.count)")

        return Array(indexpathIntersection)
    }
}
