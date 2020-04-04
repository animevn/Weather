import UIKit

struct WeatherManager{
    
    var location:GetLocation?
    
    mutating func updateWeather(updateCurrent:@escaping(WeatherCurrent?)->Void,
                       updateHour:@escaping(WeatherHour?)->Void){
        location = GetLocation{coord in
            GetWeather().getCurrentWeather(coord: coord){updateCurrent($0)}
            GetWeather().getCurrentHour(coord: coord){updateHour($0)}
                
        }
        
    }
    
}
