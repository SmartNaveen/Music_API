//
//  MusicModel.swift
//  Music_API
//
//  Created by Mr. Naveen Kumar on 15/04/21.
//

import Foundation
import UIKit

// MARK: - Welcome
struct MusicModel: Codable {
    let data: [Datum]
    let success: Int
}

// MARK: - Datum
struct Datum: Codable {
    let name: String
    let categoryImage: String
    let list: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case categoryImage = "category_image"
        case list
    }
}
