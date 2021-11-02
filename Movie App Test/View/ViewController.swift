//
//  ViewController.swift
//  Movie App Test
//
//  Created by MoonBoon on 2/11/21.
//

import UIKit

class ViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.title = "Home"
        navigationItem.searchController = searchController
    }


}

