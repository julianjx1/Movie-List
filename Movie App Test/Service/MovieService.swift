//
//  MovieService.swift
//  MovieService
//
//  Created by MoonBoon on 2/11/21.
//

import Foundation
protocol MovieServiceProtocol{
    func getMovies(search:String, completion: @escaping(_ success:Bool, _ results:Movies?, _ error:String?)->())
    
}

class MovieService:MovieServiceProtocol{
    
    func getMovies(search:String, completion: @escaping (Bool, Movies?, String?) -> ()) {
        HttpRequestHelper().getSearchResults(search: search) { success, data in
            if success {
                do {
                    let response = try JSONDecoder().decode(MovieResponseResult.self, from: data!)
                    
                    let model = response.results
                    completion(true, model, nil)
                } catch {
                    
                }
            } else {
               
            }
        }
    }
    
    
}
