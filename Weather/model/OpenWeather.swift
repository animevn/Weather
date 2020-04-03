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
    
    var list = [List]()
    let dict = Dictionary(grouping: list, by: {$0.dayOfMonth})
    
    for (_, value) in dict{
        guard
            let dtFirst = value.first?.dt,
            let dt_txtFirst = value.first?.dt_txt,
            let weatherFirst = value.first?.weather else {continue}
        
        var dt = dtFirst
        var dt_txt = dt_txtFirst
        var weather = weatherFirst
        
        let listAtNineAM = value.filter{$0.dt_txt.contains("09:00:00")}
        if listAtNineAM.count == 1{
            dt = listAtNineAM.first!.dt
            dt_txt = listAtNineAM.first!.dt_txt
            weather = listAtNineAM.first!.weather
        }
        
        var total:Double = 0
        var temp_min = value.first?.main.temp_min ?? 0
        var temp_max = value.first?.main.temp_max ?? 0
        
        for tempList in value{
            total += tempList.main.temp
            temp_min = min(temp_min, tempList.main.temp_min)
            temp_max = max(temp_max, tempList.main.temp_min)
        }
        
        let main = Main(temp: total/Double(value.count),
                        temp_min: temp_min, temp_max: temp_max)
        list.append(List(dt: dt, dt_txt: dt_txt, main: main, weather: weather))
        
    }
    
    return list.sorted{$0.dt < $1.dt}
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





















