//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 13.09.22.
//

import Foundation

struct BusinessSearch: Decodable{
    var businesses = [Business]()
    var total = 0
    var region = Region()
}
struct Region: Decodable{
    var center = Coordinate()
}
