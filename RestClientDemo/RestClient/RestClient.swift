//
//  RestClient.swift
//
//  Created by Bhushan  Borse on 24/06/20.
//  Copyright © 2020 Bhushan  Borse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum RequestType : String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

/// If you have base url so please add here and append endpoint url after that.ß
let SERVER_URL  : String = ""

public class RestClient: NSObject {
    
    /// If you have base url so please add here and append endpoint url after that.ß
    let netManager = NetworkReachabilityManager(host: "Host_name".localizedString)

    func callApi(api :String, completion: @escaping (Result<JSON, ErrorResult>) -> Void, type:RequestType, data:Any? = nil , isAbsoluteURL:Bool = false , headers : Any? = nil, isSilent : Bool = false, jsonSerialize : Bool? = true) {
        
        if !(netManager?.isReachable)!{
         /// Show offline message
            completion(.failure(.custom(string: RestClientMessages.kOfflineMsg)))
         print("Offline")
            return
        }
        
     /// If call api with showing loader
        if !isSilent {
         /// Show loader here...
        }
     
        var urlToHit = ""
        
     /// Here we check url is complete or not otherwise add base url...
        if isAbsoluteURL {
            urlToHit = api
        } else {
            urlToHit = SERVER_URL + api
        }
                
        /// Check url is not empty.
        guard let url = URL(string:urlToHit) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
                  
        if headers != nil {
            var temp = headers as! [String : String]

            temp["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = temp
        }

        /// Add parameter to httpBody
        if data != nil && (jsonSerialize ?? true) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: data! , options: [])
        } else if data != nil {
            request.httpBody = data as? Data
        }
        /// Call URL
        AF.request(request as URLRequestConvertible).responseJSON() { response in
            if !isSilent {
                /// Show loader here...
            }
            
            switch response.result {
            case .success(let value):
                completion(.success(JSON(value)))
            case .failure(let error):
                let customError = passErrorCode(andReturn: error as NSError)
                completion(.failure(.custom(string: "An error occured during request : \(customError.localizedDescription)")))

            }
        }
    }
}







/*func fetchAllRooms(completion: @escaping (_:NSError?,_:JSON?) -> Void) {
  guard let url = URL(string: "http://localhost:5984/rooms/_all_docs?include_docs=true") else {
    completion(nil, nil)
    return
  }
  af.request(url,
                    method: .get,
                    parameters: ["include_docs": "true"])
  .validate()
  .responseJSON { response in
    guard response.result.isSuccess else {
      print("Error while fetching remote rooms: \(response.result.error)")
      completion(nil,)
      return
    }

    guard let value = response.result.value as? [String: Any],
      let rows = value["rows"] as? [[String: Any]] else {
        print("Malformed data received from fetchAllRooms service")
        completion(nil)
        return
    }

   // let rooms = rows.flatMap { roomDict in return RemoteRoom(jsonData: roomDict) }
    //completion(rooms)
  }
}*/
