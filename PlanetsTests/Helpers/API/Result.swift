//
//  Result.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
