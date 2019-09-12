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
    
    var day:String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM"
            return dateFormatter.string(from: date)
        }
    }
    
    var dayOfWeek:String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
    }
    
}

struct City:Codable{
    let name:String
}


struct WeatherHourly:Codable{
    let list:[List]
    let city:City
    
    var listDaily:[List]{
        get{
            var listDaily = [List]()
            let dict =  Dictionary(grouping: list, by: {$0.day})
            
            for (_, value) in dict{
                
                var dt = value[0].dt
                var dt_txt = value[0].dt_txt
                var weather = value[0].weather
                
                let listAtNineAM = value.filter{$0.dt_txt.contains("09:00:00")}
                if listAtNineAM.count == 1{
                    dt = listAtNineAM[0].dt
                    dt_txt = listAtNineAM[0].dt_txt
                    weather = listAtNineAM[0].weather
                }
                
                var total:Double = 0
                var temp:Double = 0
                var temp_min = value[0].main.temp_min
                var temp_max = value[0].main.temp_max
                
                for tempList in value{
                    total += tempList.main.temp
                    temp_min = min(temp_min, tempList.main.temp_min)
                    temp_max = max(temp_max, tempList.main.temp_max)
                }
                temp = total/Double(value.count)
                let main = Main(temp: temp, temp_min: temp_min, temp_max: temp_max)
                listDaily.append(List(dt: dt, dt_txt: dt_txt, main: main, weather: weather))
            }
            
            return listDaily.sorted{$0.dt < $1.dt}
        }
    }
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


