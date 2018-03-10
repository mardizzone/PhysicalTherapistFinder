//
//  Model.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/6/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

struct YelpResponse : Codable {
    let total : Int
    let businesses : [Business]
}

struct Business : Codable {
    let rating : Double?
    let review_count : Int?
    let name : String
    let location : Locale
}

struct Locale : Codable {
    let address1 : String?
}
