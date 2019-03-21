//
//  Models.swift
//  Test
//
//  Created by Melania Ienciu on 18/03/2019.
//  Copyright © 2019 Melania Ienciu. All rights reserved.
//

import UIKit


struct Post: Codable {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct Message: Decodable {
    var msg: String
    
    init(msg: String) {
        self.msg = msg
    }
}

struct Product: Decodable {
    var name: String
    var description: String
    var dateAdded: Date = Date()
    var category: String
    
    init(name: String, description: String, dateAdded: Int, category: String) {
        self.name = name
        self.description = description
        self.category = category
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        let dateString = String(dateAdded)
        if let dateStr = formatter.date(from: dateString) {
            self.dateAdded = dateStr
        }
    }
}

struct ApiUrls {
    static let baseUrl = "http://demo5404306.mockable.io"
    static let logInUrl = "\(baseUrl)/login"
    static let listUrl = "\(baseUrl)/products"
}

struct MyError: Error {
    var message: String?
}
