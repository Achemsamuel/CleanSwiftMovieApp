//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Sammy on 9/22/19.
//

import Foundation

struct MoviesViewModel {
    var posterPath : URL!
}

extension Movies {
    func toViewModel() -> MoviesViewModel {
        let imagesUrl = "image.tmdb.org/t/p/"
        var posterWidth = "w342"
        var viewModel = MoviesViewModel()
        viewModel.posterPath = URL(string: ("https://\(imagesUrl)\(posterWidth)\(posterPath)"))
        return viewModel
    }
}
