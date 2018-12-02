//
//  Image.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}
