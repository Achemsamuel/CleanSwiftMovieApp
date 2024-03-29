//
//  MoviesAppInteractor.swift
//  MovieApp
//
//  Created by Achem Samuel on 9/22/19.
//  Copyright (c) 2019 Achem Samuel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol UpcomingMoviesBusinessLogic
{
    func fetchUpcomingMovies(request: UpcomingMovies.FetchUpcomingMovies.Request)
}

protocol UpcomingMoviesDataStore
{
    var upcomingMovies : [Movies] {get set}
}

class UpcomingMoviesInteractor: UpcomingMoviesBusinessLogic, UpcomingMoviesDataStore
{
    
  var upcomingMovies: [Movies] = []
  var presenter: UpcomingMoviesPresentationLogic?
  let apiClient = ApiClient()
    
  func fetchUpcomingMovies(request: UpcomingMovies.FetchUpcomingMovies.Request) {
    apiClient.getUpcomingMovies { [weak self] result in
        switch result {
        case .success(let movies):
            self?.upcomingMovies = movies
            self?.presenter?.presentUpcomingMovies(response: UpcomingMovies.FetchUpcomingMovies.Response(upcomingMovies: movies))
        case .failure(let error):
            print("Error \(error.localizedDescription)")
        }
    }
  }
    
}
