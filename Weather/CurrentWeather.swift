import UIKit

class CurrentWeather:UIView{
    
    let height:CGFloat = screen().y * 3/10 - inset
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: frame.size))
        backgroundColor = .orange
        alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    
    
    
    
    
}
