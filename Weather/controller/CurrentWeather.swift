import UIKit

class CurrentWeather:UIView{
    
    let height:CGFloat = screen().y * 3.5 / 10 - Constants.inset * 2
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        alpha = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
