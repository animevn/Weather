import UIKit

func screen()->(x:CGFloat, y:CGFloat, headY:CGFloat, bottomY:CGFloat){
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    //        let center = CGPoint(x: width/2, y: height/2)
    
    switch (width, height) {
        
    //XSMax, XR portrait : status bar = 44, bottom bar = 34
    case (414, 896):
        //        print("XSMax, XR")
        return (414, 896 - 44 - 34, 44, 34)
        
    //X, XS portrait : status bar = 44, bottom bar = 34
    case (375, 812):
        //        print("X, XS")
        return (375, 812 - 44 - 34, 44, 34)
        
    //6 Plus, 6S Plus, 7 Plus, 8 Plus portrait : status bar = 18
    case (414, 736):
        //        print("6 Plus, 6s Plus, 7 Plus, 8 Plus")
        return (414, 736 - 18, 18, 0)
        
    //6, 6S, 7, 8 portrait : status bar = 20
    case (375, 667):
        //        print("6, 6s, 7, 8")
        return (375, 667 - 20, 20, 0)
        
    //SE portrait : status bar = 20
    case (320, 568):
        //      print("SE")
        return (320, 568 - 20, 20, 0)
        
    //default value which never used
    default:
        //      print("default")
        return (width, height - 50, 50, 0)
    }
}

func decodeData<T:Codable>(data:Data) -> T?{
    
//    //old code, which can be shorten to just one row
//    do{
//        let objectT = try JSONDecoder().decode(T.self, from:data)
//        return objectT
//    }catch let error{
//        print(error)
//        return nil
//    }
    
    return try? JSONDecoder().decode(T.self, from: data)
}

extension Date{
    
    func toWeekDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd-MMM"
        return dateFormatter.string(from: self)
    }
    
    func toMonthDay()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM"
        return dateFormatter.string(from: self)
    }
    
    func toHour()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
}

extension Double{
    
    func toInt()->Int{
        return Int(self.rounded())
    }
    
}

extension String{
    
    func upperFirstLetter()->String{
        return (self.first?.uppercased())! + self.dropFirst()
    }
    
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
    
    func loadImageFromUrl(stringUrl:String){
        
        image = nil
        
        if let imageCache = imageCache.object(forKey: stringUrl as NSString){
            image = imageCache
            print("image cached already")
            return
        }
        
        guard let url = URL(string: stringUrl) else {return}
        
        DispatchQueue.global().async {[weak self] in
            
            if let data = try? Data(contentsOf: url){
                
                if let image = UIImage(data: data){
                    
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: stringUrl as NSString)
                        self?.image = image
                    }
                }
            }
        }
        
    }
    
}

























