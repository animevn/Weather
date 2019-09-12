import Foundation
import Alamofire

class GetFlickr{
    
    private let API = "8af3f7e81985dfc0c684d0cb200537e6"
    private let URL = "https://www.flickr.com/services/rest/"
    private let METHOD = "flickr.photos.search"
    private let GROUP = "1463451@N25"
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
//    func decodeData(data:Data)->Flickr?{
//        do{
//            let object = try JSONDecoder().decode(Flickr.self, from:data)
//            return object
//        }catch let error{
//            print(error)
//            return nil
//        }
//    }
    
    private func getUrlFromFlickr(flickr:Flickr?)->URL?{
        guard let flickr = flickr else {return nil}
        let photoList = flickr.photos.photo.filter{
            $0.ispublic == 1
        }
        let count = photoList.count
        var string = ""
        if count > 0{
            let random = Int(arc4random_uniform(UInt32(count)))
            let farm = photoList[random].farm
            let server = photoList[random].server
            let id = photoList[random].id
            let secret = photoList[random].secret
            string = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
        }
        return Foundation.URL(string: string)
    }
    
    func getData(coord:Coord, completion:@escaping (URL?)->Void){
        
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
            let url = self.getUrlFromFlickr(flickr: decodeData(data: data))
            completion(url)
        }
    }
    
}
