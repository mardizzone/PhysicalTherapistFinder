//
//  PTListViewController.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/8/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class PTListViewController: UIViewController, ResultsDelegate {

    @IBOutlet var ptTableView: UITableView!
    var arrayOfPTs = [Business]()
    
    override func viewWillAppear(_ animated: Bool) {
        ptTableView.rowHeight = UITableViewAutomaticDimension
        ptTableView.estimatedRowHeight = 140
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PTListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPTs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as! YelpTableViewCell
        cell.nameLabel.text = arrayOfPTs[indexPath.row].name
        if let address = arrayOfPTs[indexPath.row].location.address1 {
            cell.addressLabel.text = address
        }
        if let rating = arrayOfPTs[indexPath.row].rating {
            cell.ratingLabel.text = "\(rating)⭐️"
        }
        if let reviewCount = arrayOfPTs[indexPath.row].review_count {
            cell.reviewsLabel.text = "\(reviewCount) reviews"
        }
        return cell
    }
}


