//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 12.07.2021.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    var image = UIImage()
    
    func downloadImage(_ imageURL: String) -> UIImage{
        let cacheKey = NSString(string: imageURL)
        
        if let img = cache.object(forKey: cacheKey){
            image = img
        }else {
            let url = "https://image.tmdb.org/t/p/w200/"+imageURL
                
            let imageData = try? Data(contentsOf: URL(string: url)!)
            image = UIImage(data: imageData!) ?? UIImage()
            cache.setObject(image, forKey: cacheKey)
            
        }
        return image
    }
    
    func getMovieList(page_num: String, completion: @escaping ([MovieResponse]?) -> Void){
        
        var url = URLComponents(string: "https://api.themoviedb.org/3/movie/popular?language=en%EF%BF%BEUS")
        
        url?.queryItems = [URLQueryItem(name: "api_key", value: "fd2b04342048fa2d5f728561866ad52a"),
                           URLQueryItem(name: "page", value: page_num)
        ]
        
        let task = URLSession.shared.dataTask(with: URL(string: url!.description)!) { (data, response, err) in
            
            guard let dataa = data else {
                completion(nil)
                return
            }
            do{
                let json = try JSONDecoder().decode(MoviesResponse.self, from: dataa)
                completion(json.all)
            
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
        }
        task.resume()
    }
    
    func getMovieDetail(movieID: Int, completion: @escaping (SearchResponse?) -> Void){
        let endpoint = "https://api.themoviedb.org/3/movie/\(String(movieID))?language=en%EF%BF%BEUS&api_key=fd2b04342048fa2d5f728561866ad52a"
        
        let url = URL(string: endpoint)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, err) in
            guard let dataa = data else {
                completion(nil)
                return
            }
            do{
                let json = try JSONDecoder().decode(SearchResponse.self, from: dataa)
                completion(json)
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }
    
}
