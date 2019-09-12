import Alamofire

class GetWeather{
    
    private let API = "1a9dc82f0a3a7e535acb3ac84407ad81"
    private let urlCurrent = "https://api.openweathermap.org/data/2.5/weather?"
    private let urlForecast = "https://api.openweathermap.org/data/2.5/forecast?"

    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    func getCurrent(coord:Coord, completion:@escaping (WeatherCurrent?)->Void){
        let parameters:Parameters = ["appid":API, "lat":coord.lat, "lon":coord.lon]
        
        Alamofire.request(urlCurrent, method: .get, parameters: parameters).responseData{
            guard let data = $0.data else {return}
            completion(decodeData(data: data))
        }
    }
    
    func getHourly(coord:Coord, completion:@escaping (WeatherHourly?)->Void){
        let parameters:Parameters = ["appid":API, "lat":coord.lat, "lon":coord.lon]
        
        Alamofire.request(urlForecast, method: .get, parameters: parameters).responseData{
            guard let data = $0.data else {return}
            completion(decodeData(data: data))
        }
    }
    
    
    
    
}
