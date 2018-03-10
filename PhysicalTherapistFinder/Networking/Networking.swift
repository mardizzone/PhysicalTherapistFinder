//
//  Networking.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/6/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import Alamofire
import GooglePlaces

class Networking {
    class func retrieveYelpData(selectedPlace: GMSPlace, completionHandler: @escaping (YelpResponse) -> () ) {
        let yelpheaders : HTTPHeaders = [ "Authorization": "Bearer ULXnRU_aqsfURAoy0WzhDhpjee35kw8q5qNXB3x8wsRuColGTWgZLUCIUYQUO0zyibzpSNzszT47-chCGvr5FNvp8EvPT5Iik_YAvJpBvSMMlU2LTaZ_n4c2vomfWnYx"]
        let params : Parameters = ["latitude" : selectedPlace.coordinate.latitude, "longitude" : selectedPlace.coordinate.longitude, "radius" : 4000, "term" : "physical therapist", "sort_by" : "rating"]
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search", method: .get, parameters: params, encoding: URLEncoding.default, headers: yelpheaders).responseData { response in
            switch response.result {
            case .success(let value):
                if let businessJSON = Parser.parse(yelpData: value) {
                    completionHandler(businessJSON)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
