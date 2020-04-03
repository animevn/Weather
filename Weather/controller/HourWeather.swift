import UIKit

class HourWeather:UIView{
    
    let height:CGFloat = screen().y * 1.5 / 10
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        alpha = 0.1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
