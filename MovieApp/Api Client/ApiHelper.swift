//
//  ApiHelper.swift
//  Movie Finder
//
//  Created by Achem Samuel on 3/23/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation


/*------------------------
 Mark: Networking Methods
 ------------------------*/
class ApiClient {
    let apiKey = UserDefaults().apiKey ?? ""
    let decoder = JSONDecoder()
    var upcomingMovies : MoviesResponse?
    
    func getApiKey () {
        guard let path = Bundle.main.path(forResource: "MovieConfiguration", ofType: "plist"), let movieConfigDict = NSDictionary.init(contentsOfFile: path) else {
            fatalError("Path/Movie Configuration Could not be found")
            
        }
        let apiKey = (movieConfigDict.value(forKey: "ApiKey") as! String)
        UserDefaults().apiKey = apiKey
    }
    
    //movieDB Configurations Set up
    func fetchConfigurations (onComplete: @escaping (_ message : String)-> ()) -> Void {
        let apiKey = UserDefaults().apiKey
        let configurationsUrl = "\(HTTPEndPointResources.serviceUrl)/configuration?api_key=\(apiKey ?? "")"
        
        var request = URLRequest.init(url: URL.init(string: configurationsUrl)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error fetching configurations: \(String(describing: error))")
                onComplete("Error fetching configurations: \(String(describing: error))")
                
            } else {
                
                guard let configurationsJson = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary else { fatalError()
                }
                guard let imagesDictionary = configurationsJson.value(forKey: "images") as? NSDictionary else {
                    fatalError()
                }
                let baseUrl = (imagesDictionary.value(forKey: "secure_base_url") as! String)
                onComplete("BaseUrl \(String(describing: baseUrl))")
            }
        }.resume()
    }
    
    /*------------------------
      Upcoming Movies Api Methods
     ------------------------*/
    func get(url: String, completion: @escaping ((Result<Data, Error>)-> Void)) -> Void {
        
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {(data, response, error) in
             guard error == nil else {
                completion(.failure(error!))
                print("Error fetching upcoming Movies: \(String(describing: error))")
                return
            }
            completion(.success(data!))
        }.resume()
       
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Movies], Error>)-> Void) {
        
        let moviesUrl = ("\(HTTPEndPointResources.serviceUrl)/movie/upcoming?api_key=\(self.apiKey)&language=en-US&page=1")
        get(url: moviesUrl) { [weak self] result in
            
            switch result {
            case .success(let data):
                print("results \(data)")
                do {
                    guard let upcomingMovies = try self?.decoder.decode(MoviesResponse.self, from: data) else {return}
                    self?.upcomingMovies = upcomingMovies
                    completion(.success(upcomingMovies.movies))
                } catch {
                    completion(.failure(error))
                    print("Error deocing upcoming movies \(error.localizedDescription)")
                }
                
            case .failure(let error):
                completion(.failure(error))
                print("Error deocing upcoming movies \(error.localizedDescription)")
                break
            }
            
        }
    }
    
}
