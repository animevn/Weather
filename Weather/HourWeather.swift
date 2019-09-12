import UIKit

class HourWeather:UIView{
    
    let height:CGFloat = screen().y * 1.5/10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        alpha = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    
}

