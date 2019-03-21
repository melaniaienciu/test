//
//  ApiServices.swift
//  Test
//
//  Created by Melania Ienciu on 18/03/2019.
//  Copyright © 2019 Melania Ienciu. All rights reserved.
//

import UIKit

class ApiServices {
    init() {}
    static let shared = ApiServices()
    
    func request(post: Post, completion:( (Message?, Error?) -> Void)?) {
        guard let url = URL(string: ApiUrls.logInUrl) else {
            print("Error: url")
            completion?(nil, MyError(message: "Error: url"))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let encoder = JSONEncoder ()
        do {
            let jsonData = try encoder.encode(post)
            urlRequest.httpBody = jsonData
            print("jsonData: ", String(data: jsonData, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(nil, error)
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { (responseData, _, error) in
            guard error == nil else {
                completion?(nil, MyError(message: "\(error!)"))
                return
            }
            if let data = responseData {
                do {
                    //decode --> struct
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Message.self, from: data)
                    completion?(response, nil)
                } catch _ {
                    completion?(nil, MyError(message: "error decoding"))
                }
            } else {
                completion?(nil, MyError(message: "no readable data received in response"))
            }
        }
        task.resume()
    }
    
    // GET list
    func getList(completion: (([Product]?, Error?) -> Void)?) {
        guard let url = URL(string: ApiUrls.listUrl) else {
            print("Error: url")
            completion?(nil, MyError(message: "Error: URL"))
            return
        }
        var urlGetList = URLRequest(url: url)
        urlGetList.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlGetList) { (responseData, _, error) in
            guard error == nil else {
                completion?(nil, MyError(message: "\(error!)"))
                return
            }
            if let data = responseData {
                do {
                    //decode --> struct
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    completion?(products, nil)
                } catch _ {
                    completion?(nil, MyError(message: "error decoding"))
                }
            } else {
                completion?(nil, MyError(message: "no readable data received in response"))
            }
        }
        task.resume()
        
    }


}
