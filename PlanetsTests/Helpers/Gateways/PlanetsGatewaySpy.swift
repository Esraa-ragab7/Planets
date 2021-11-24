//
//  PlanetsGateway.swift
//  PlanetsTests
//
//  Created by Esraa Mohamed Ragab on 24/11/2021.
//

import Foundation
@testable import Planets

class PlanetsGateway: BooksGateway {
    var fetchBooksResultToBeReturned: Result<[Book]>!
    var addBookResultToBeReturned: Result<Book>!
    var deleteBookResultToBeReturned: Result<Void>!
    
    var deletedBook: Book!
    
    func fetchBooks(completionHandler: @escaping FetchBooksEntityGatewayCompletionHandler) {
        
    }
    
    func add(parameters: AddBookParameters, completionHandler: @escaping AddBookEntityGatewayCompletionHandler) {
        
    }
    
    func delete(book: Book, completionHandler: @escaping DeleteBookEntityGatewayCompletionHandler) {
        deletedBook = book
        completionHandler(deleteBookResultToBeReturned)
    }
}
