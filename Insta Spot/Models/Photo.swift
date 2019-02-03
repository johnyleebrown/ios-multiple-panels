//
//  Photo.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/31/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

// retrive a random photo
struct URLs: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct Image: Decodable {
    let id: String
    let width: Int
    let height: Int
    let likes: Int
    let color: String
    let urls: URLs
    let keyNotExist: String?
}
