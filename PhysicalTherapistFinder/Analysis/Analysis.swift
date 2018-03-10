//
//  Analysis.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/8/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

class Analyzer {
    
    class func findNumberOfPTsInArea(yelpData: YelpResponse) -> Int {
        return yelpData.total
    }
    
    class func findNumberOfPTsWithRatings(businesses: [Business]) -> Int {
        var ptsWithRatings = 0
        for business in businesses {
            if business.rating != nil {
                ptsWithRatings += 1
            }
        }
        return ptsWithRatings
    }
    
    class func totalNumberOfReviews(businesses: [Business]) -> Int {
        var totalNumberOfReviews = 0
        for business in businesses {
            if let reviewCount = business.review_count {
                totalNumberOfReviews += reviewCount
            }
        }
        return totalNumberOfReviews
    }
    
    class func findAverageRating(businesses : [Business]) -> Double {
        var arrayOfAllRatings = [Double]()
        for business in businesses {
            if let rating = business.rating {
                arrayOfAllRatings.append(rating)
            }
        }
        let nonRoundedAverage = arrayOfAllRatings.average
        let roundedAverage = Double(round(10*nonRoundedAverage)/10)
        return roundedAverage
    }
    
}



