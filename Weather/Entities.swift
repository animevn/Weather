import Foundation

struct Coord:Codable{
    let lat:Double
    let lon:Double
}

struct Weather:Codable{
    let description:String
    let icon:String
}

struct Main:Codable{
    let temp:Double
    let temp_min:Double
    let temp_max:Double
    
    var tempC:Double{
        get{
            return temp - 273.15
        }
    }
    
    var maxC:Double{
        get{
            return temp_max - 273.15
        }
    }
    
    var minC:Double{
        get{
            return temp_min - 273.15
        }
    }
    
    var tempF:Double{
        get{
            return tempC * 1.8 + 32
        }
    }
    
    var maxF:Double{
        get{
            return maxC * 1.8 + 32
        }
    }
    
    var minF:Double{
        get{
            return minC * 1.8 + 32
        }
    }
}

struct WeatherCurrent:Codable{
    let weather:[Weather]
    let main:Main
    let name:String
}

struct List:Codable{
    let dt:Double
    let dt_txt:String
    let main:Main
    let weather:[Weather]
    
    var date:Date{
        get{
            return Date(timeIntervalSince1970: dt)
        }
    }
}

struct City:Codable{
    let name:String
}

struct WeatherHourly:Codable{
    let city:City
    let list:[List]
}

struct Photo:Codable{
    let id:String
    let secret:String
    let farm:Int
    let server:String
    let ispublic:Int
}

struct Photos:Codable{
    let photo:[Photo]
}

struct Flickr:Codable{
    let photos:Photos
}

extension Double{
    
    func toInt()->Int{
        return Int(self.rounded())
    }
}
