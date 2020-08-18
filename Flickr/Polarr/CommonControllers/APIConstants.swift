//
//  APIConstants.swift
//  Polarr
//
//  Created by Muzammil Mohammad on 18/08/20.
//  Copyright © 2020 Turing. All rights reserved.
//

import Foundation

//APP CONSTANTS KEYS
let PHOTOS           = "photos"
let PHOTO            = "photo"
let FARM             = "farm"
let SERVER           = "server"
let ID               = "id"
let SECRET           = "secret"

struct APIConstants
{
    static let flickrSearch     = "https://api.flickr.com/services/rest/?&method=flickr.photos.search"

    static func filterImage(data: Dictionary<String, Any>)-> String {
        
        let farm: String    = toString(data[FARM])
        let server: String  = toString(data[SERVER])
        let photoId: String = toString(data[ID])
        let secret: String  = toString(data[SECRET])
        
        let imageURL = "https://farm" + farm + ".staticflickr.com/" +  server + "/" + photoId + "_" + secret + "_b.jpg"

        return imageURL
    }
}
