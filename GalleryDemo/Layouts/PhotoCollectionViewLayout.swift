//
//  PhotoCollectionViewLayout.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 02/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewLayoutDelegate: class {
     // Method to ask the delegate for the height of the image
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexpath indexpath: IndexPath) -> CGFloat
}

class PhotoCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: PhotoCollectionViewLayoutDelegate?
    
    // Configurable properties
    private var numberOfColumn = 2
    private var cellPadding: CGFloat = 5
    
    // Array to keep a cache of attributes.
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // Content height and size
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat{
        guard let collectionView = collectionView else {
            return 0
        }
        
        let inset = collectionView.contentInset
        return collectionView.bounds.width - (inset.left + inset.right)
        
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    
    override func prepare() {
        super.prepare()
        cache.removeAll()
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        // Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let columnWidth = contentWidth / CGFloat(numberOfColumn)
        var xOffset = [CGFloat]()
        for column in 0..<numberOfColumn{
            xOffset.append(CGFloat(column)*columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumn)
        
        // Iterates through the list of items in the first section
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexpath = IndexPath(item: item, section: 0)
            
            // Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
            let photoheight = delegate?.collectionView(collectionView: collectionView, heightForPhotoAtIndexpath: indexpath)
            let height = 2 * cellPadding + (photoheight ?? CGFloat(0))
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexpath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            // Updates the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumn - 1) ? (column + 1) : 0
        
            
        }
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attribute in cache{
            if attribute.frame.intersects(rect){
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}
