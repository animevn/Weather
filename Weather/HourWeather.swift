import UIKit

class HourWeather:UIView{
    
    let height:CGFloat = screen().y * 1.5/10
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: frame.size))
        backgroundColor = .red
        alpha = 0.02
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    
}

