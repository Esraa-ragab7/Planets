//
//  PlanetsApiResponse.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

struct PlanetsApiResponse: Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Planet]?
}
