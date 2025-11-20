//
//  CitiesModel.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import Foundation

struct CitiesModel: Decodable {
    let error: Bool
    let msg: String
    let data: [String]
}
