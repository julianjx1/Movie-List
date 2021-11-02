//
//  MoviesViewModel.swift
//  MoviesViewModel
//
//  Created by MoonBoon on 2/11/21.
//

import Foundation
class MoviesViewModel:NSObject{
    private var movieService:MovieServiceProtocol
    
    var reloadTableView:(()->Void)?
    var movies = Movies()
    var moviesCellViewModels = [MovieCellViewModel](){
        willSet{
            reloadTableView?()
        }
    }
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    func fetchData(movies: Movies){
        self.movies = movies
        var viewmodels = [MovieCellViewModel]()
        for movie in movies{
            viewmodels.append(createCellModel(movie: movie))
        }
        moviesCellViewModels = viewmodels
        
    }
    func createCellModel(movie: Movie)->MovieCellViewModel{
        
        return MovieCellViewModel(poster: movie.posterPath, movieTitle: movie.title, movieOverview: movie.overview)
    }
    
    func getCellViewModel(at indexPath:IndexPath)->MovieCellViewModel{
        return moviesCellViewModels[indexPath.row]
    }
    func getMovies(search:String){
        movieService.getMovies(search: search) { success, results, error in
            if success, let movies = results{
                self.fetchData(movies: movies)
            }
        }
    }
    
}
