//
//  ApiPlanetsResponse.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

struct ApiPlanetsResponse: Codable {
    let count : Int
    let next : String?
    let previous : String?
    let planets : [Planet]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case planets = "results"
    }
}
