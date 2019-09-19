//
//  APIManager.swift
//  MobileGuide
//
//  Created by Jiratip Hemwutthipan on 17/9/2562 BE.
//  Copyright © 2562 whoami. All rights reserved.
//

import Foundation

class APIManager {
    func getMobile(url: String, completion: @escaping ([MobileModel]?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                print("error")
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let mobile = try JSONDecoder().decode([MobileModel].self, from: data)
                        print(mobile)
                        completion(mobile)
                    } catch (let error) { // get error
                        print(error)
                        print("parse JSON failed------")
                    }
                }
            }
        }
        task.resume()
    }
    
    func getMobileImage(url: String, completion: @escaping ([ImageModel]?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                print("error")
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let mobile = try JSONDecoder().decode([ImageModel].self, from: data)
                        print(mobile)
                        completion(mobile)
                    } catch (let error) { // get error
                        print(error)
                        print("parse JSON failed------")
                    }
                }
            }
        }
        task.resume()
    }
}
