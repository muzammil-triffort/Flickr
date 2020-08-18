//
//  APIManager.swift
//  Polarr
//
//  Created by Muzammil Mohammad on 18/08/20.
//  Copyright © 2020 Turing. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager: NSObject
{
    static let sharedInstance = APIManager()

    func RequestManager(url: String!, method: String!) -> URLRequest
    {
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    func getFlickerImages(searchText: String, page: Int, onSuccess: @escaping(Dictionary<String, Any>) -> Void, onFailure: @escaping(Error) -> Void)
    {
        if searchText == "" { return }
        
        let apiString       = "&api_key=\(FLICKR_API_KEY)"
        let searchString    = "&tags=\(searchText)"
        let format          = "&format=json"
                
        let urlString: String  = APIConstants.flickrSearch + apiString + format + searchString
        let truncated: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let url = URL(string:truncated)
        
        let request = self.RequestManager(url: url?.description, method: "GET")
   
        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            var responseString: String = String(decoding: data!, as: UTF8.self)
            responseString = responseString.replacingOccurrences(of: "jsonFlickrApi(", with: "")
            responseString = String(responseString.dropLast())

            if let data = responseString.data(using: String.Encoding.utf8) {
                do {
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>

                    onSuccess(jsonDictionary!)
                    
                } catch {
                    onSuccess(Dictionary())
                }
            }
            else {
                onFailure(error!)
            }
        })

    task.resume()
        
    }
}
