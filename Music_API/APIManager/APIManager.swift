//
//  ApiManager.swift
//  Music_API
//
//  Created by Mr. Naveen Kumar on 15/04/21.
//

import Foundation
import UIKit
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    // MARK:- FetchGenericData using model type
    func fetchGenericData<T:Decodable>(urlString:String, dict: [String:Any],requestType: HTTPMethod, completion: @escaping (T) -> (), failure: @escaping(String)->()){
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(url)
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: [:]).responseJSON { (response:AFDataResponse<Any>) in
            print(response.debugDescription)
            print("Response =====  ",response.result)
            switch(response.result){
            case .success(let res):
                print("result \(res)")
                guard let data = response.data else { return }
                do{
                    let userModel = try JSONDecoder().decode(T.self, from: data)
                    completion(userModel)
                }catch let error {
                    print("error \(error.localizedDescription)")
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }.resume()
    }
    
}
