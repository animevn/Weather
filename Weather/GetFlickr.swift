import Foundation
import Alamofire

class GetFlickr{
    
    private let API = "8af3f7e81985dfc0c684d0cb200537e6"
    private let URL = "https://www.flickr.com/services/rest/"
    private let METHOD = "flickr.photos.search"
    private let GROUP = "1463451@N25"
    
    func getData(coord:Coord, completion:@escaping (Data)->Void){
        let parameters:Parameters = [
            "method":METHOD,
            "group_id":GROUP,
            "api_key":API,
            "lat":coord.lat,
            "lon":coord.lon,
            "radius":"10",
            "format":"json",
            "nojsoncallback":"1"
        ]
        Alamofire.request(URL, method: .get, parameters: parameters).responseData{
            guard let data = $0.data else {return}
            completion(data)
        }
    }
    
}
