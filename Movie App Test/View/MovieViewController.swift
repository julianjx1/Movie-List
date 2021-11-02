//
//  MovieViewController.swift
//  MovieViewController
//
//  Created by MoonBoon on 2/11/21.
//

import UIKit

class MovieViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var viewModel = {
        MoviesViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.title = "Home"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        viewModel.getMovies(search: "marvel")
        viewModel.reloadTableView = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.moviesCellViewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieItem") as? MovieItemCell else{
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel

        return cell
    }
    

}
extension MovieViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.getMovies(search: searchController.searchBar.text ?? "marvel")
        
    }
    
    

}
