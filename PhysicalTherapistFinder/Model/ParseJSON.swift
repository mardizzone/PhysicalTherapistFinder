//
//  ParseJSON.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/8/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

class Parser {
    
    class func parse(yelpData: Data) -> YelpResponse? {
        let decoder = JSONDecoder()
        do {
            let yelpJSON = try decoder.decode(YelpResponse.self, from: yelpData)
            return yelpJSON
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            return nil
        }
        
    }
    
    
    
    
}
