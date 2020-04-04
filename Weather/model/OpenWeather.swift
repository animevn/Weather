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
   
    var dateWeather:Date{
        get{
            return Date(timeIntervalSince1970: dt)
        }
    }
    
    var dayOfMonth:String{
        get{
            return dateWeather.toMonthDay()
        }
    }
    
    var dayOfWeek:String{
        get{
            return dateWeather.toWeekDay()
        }
    }
    
    var hour:String{
        get{
            return dateWeather.toHour()
        }
    }
    
}

struct City:Codable{
    let name:String
}



func getDailyList(list:[List]) -> [List] {
    
    var listDaily = [List]()
    let dict = Dictionary(grouping: list, by: {$0.dayOfMonth})
    
    for (_, value) in dict{
        
        guard let valueFirst = value.first else {continue}
        
        var dt = valueFirst.dt
        var dt_txt = valueFirst.dt_txt
        var weather = valueFirst.weather
        
        let listAtNineAM = value.filter{$0.dt_txt.contains("09:00:00")}
        if listAtNineAM.count == 1{
            dt = listAtNineAM.first!.dt
            dt_txt = listAtNineAM.first!.dt_txt
            weather = listAtNineAM.first!.weather
        }
        
        var total:Double = 0
        var temp_min = valueFirst.main.temp_min
        var temp_max = valueFirst.main.temp_max
        
        for tempList in value{
            total += tempList.main.temp
            temp_min = min(temp_min, tempList.main.temp_min)
            temp_max = max(temp_max, tempList.main.temp_min)
        }
        
        let main = Main(temp: total/Double(value.count),
                        temp_min: temp_min, temp_max: temp_max)
        listDaily.append(List(dt: dt, dt_txt: dt_txt, main: main, weather: weather))
        
    }
    
    return listDaily.sorted{$0.dt < $1.dt}
}

struct WeatherHour:Codable{
    let list:[List]
    let city:City
    
    var listDaily:[List]{
        
        get{
            return getDailyList(list: list)
        }
        
    }
    
}





















