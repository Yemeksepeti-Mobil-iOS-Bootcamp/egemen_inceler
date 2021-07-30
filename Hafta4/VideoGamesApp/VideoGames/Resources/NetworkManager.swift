import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func getMovieList(completion: @escaping ([Game]?)-> Void){
        
        let parameters = ["key": "02d91e9814ee44848c9c130ee0d1187e"]
        AF.request("https://api.rawg.io/api/games",method: .get ,parameters: parameters).responseDecodable(of: Games.self) { (response) in
            if response.value != nil {
                if response.value!.all.count > 0 {
                    guard let movies = response.value?.all else {
                        completion(nil)
                        return
                    }
                    completion(movies)
                }else {
                    completion(nil)
                    return
                }
            }
        }
    }
    
    func getMovieDetail(bookName: String, completion: @escaping (GameDetail?)->Void){
        
        let parameters = ["key": "02d91e9814ee44848c9c130ee0d1187e"]
        AF.request("https://api.rawg.io/api/games/"+bookName, method: .get, parameters: parameters).responseDecodable(of: GameDetail.self) { (response) in
            guard let response = response.value else {
                completion(nil)
                return
            }
            completion(response)
        }
    }
    
    
}
