import UIKit

class HourWeather:UIView{
    
    let height:CGFloat = screen().y * 1.5/10
    var isUpdateLayout = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    private func createLayout(){
        
    }
    
    override func updateConstraints() {
        if !isUpdateLayout{
            super.updateConstraints()
            return
        }else{
            createLayout()
            super.updateConstraints()
            isUpdateLayout = false
            return
        }
    }
}

