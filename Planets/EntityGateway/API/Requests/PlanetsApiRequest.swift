//
//  PlanetsApiRequest.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import Foundation

struct PlanetsApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let path = "planets"
        let url: URL! = URL(string: "\(ProductionServer.baseURL)\(path)")
        var request = URLRequest(url: url)
                
        request.httpMethod = "GET"
        
        return request
    }
}
