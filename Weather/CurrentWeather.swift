import UIKit

class CurrentWeather:UIView{
    
    let height:CGFloat = screen().y * 3.5/10 - inset * 2
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    private func setLayout(){
        
    }
    
    override func updateConstraints() {
        setLayout()
        super.updateConstraints()
    }
    
    
    
    
}
