//
//  DataServices.swift
//  AlamofireDemo
//
//  Created by MTQ on 8/2/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import Foundation
import Alamofire

class DataServices {
    static let shared: DataServices = DataServices()
    
    func get(_ urlAPI: String, completion: @escaping (Any) -> Void) {
        Alamofire.request(urlAPI).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let json):
                completion(json)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func post(_ urlAPI: String, param: [String: Any], completion: @escaping () -> Void) {
        Alamofire.request(urlAPI, method: .post, parameters: param).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                completion()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func delete(_ urlAPI: String, param: [String: Any], completion: @escaping () -> Void) {
        Alamofire.request(urlAPI, method: .delete, parameters: param).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let json):
                print(json)
                completion()
            case .failure(let error):
                print(error)
            }
        })
    }
}
