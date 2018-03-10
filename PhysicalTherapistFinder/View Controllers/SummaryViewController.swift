//
//  ViewController.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/6/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import GooglePlaces

class SummaryViewController: UIViewController  {

    @IBOutlet var placeTitle: UILabel!
    @IBOutlet weak var pinkView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var lightPinkView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var viewResultsButton: UIButton!
    @IBOutlet weak var ptsInAreaLabel: UILabel!
    @IBOutlet weak var ptsWithRatingsLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    var delegate: ResultsDelegate?
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var arrayOfPTs = [Business]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        organizeUI()
    }
}


//MARK: - Google Places Auto Complete
extension SummaryViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        print(place.coordinate)
        Networking.retrieveYelpData(selectedPlace: place, completionHandler: { yelpresponse in
            self.updateTotalNumberOfPTsLabel(yelpData: yelpresponse)
            self.updateUIToReflectYelpData(businesses: yelpresponse.businesses)
            self.arrayOfPTs = yelpresponse.businesses
            self.arrayOfPTs = self.arrayOfPTs.sorted(by: { $0.rating! > $1.rating! })
            self.viewResultsButton.isEnabled = true
            self.viewResultsButton.isHidden = false
            self.placeTitle.text = place.name
            self.placeTitle.isHidden = false
        })
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // called when error occurrs
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

//MARK: - Update UI To Reflect Yelp Data
extension SummaryViewController {
    func updateTotalNumberOfPTsLabel(yelpData: YelpResponse) {
        ptsInAreaLabel.text = "\(Analyzer.findNumberOfPTsInArea(yelpData: yelpData))"
        ptsWithRatingsLabel.text = "\(Analyzer.findNumberOfPTsInArea(yelpData: yelpData))"
    }
    
    func updateUIToReflectYelpData(businesses: [Business]) {
        averageRatingLabel.text = "\(Analyzer.findAverageRating(businesses: businesses))"
        numberOfReviewsLabel.text = "\(Analyzer.totalNumberOfReviews(businesses: businesses))"
    }
}

//MARK: - Setup Initital UI
extension SummaryViewController {
    func organizeUI() {
        setUpResultsController()
        viewResultsButton.makeoverButton()
        pinkView.layer.cornerRadius = pinkView.frame.size.width/2
        pinkView.clipsToBounds = true
        orangeView.layer.cornerRadius = orangeView.frame.size.width/2
        orangeView.clipsToBounds = true
    }
    
    func setUpResultsController() {
        //setup the autocomplete for the search bar that leverages the Google Places API
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        let subView = UIView(frame: CGRect(x: 0, y: 70.0, width: 350.0, height: 45.0))
        searchController?.searchBar.barTintColor = UIColor.lightGray
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
}

//MARK: - Data Transfer Methods
extension SummaryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listVC = segue.destination as! PTListViewController
        self.delegate = listVC
        delegate?.arrayOfPTs = arrayOfPTs
    }
}

