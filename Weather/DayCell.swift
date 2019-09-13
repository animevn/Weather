import UIKit
import Cartography

class DayCell:UIView{
    
    var height:CGFloat{
        get{
            return (screen().y * 5/10 - inset)/CGFloat(numOfRows)
        }
    }
    
    private var lbMinMax = UILabel()
    private var lbWeekDay = UILabel()
    private var ivWeatherIcon = UIImageView()
    private var numOfRows:Int!
    
    func setNumOfRows(numOfRows:Int){
        self.numOfRows = numOfRows
    }
    
    private func createViews(){
        addSubview(lbMinMax)
        addSubview(lbWeekDay)
        addSubview(ivWeatherIcon)
    }
    
    private func setupViews(){
        lbWeekDay.textColor = .white
        lbWeekDay.shadowColor = .darkGray
        lbWeekDay.adjustsFontSizeToFitWidth = true
        lbWeekDay.font = .systemFont(ofSize: height * 0.4)
        
        lbMinMax.textColor = .white
        lbMinMax.shadowColor = .darkGray
        lbMinMax.adjustsFontSizeToFitWidth = true
        lbMinMax.font = .systemFont(ofSize: height * 0.4)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        createViews()
//        setupViews()
//    }
    
    //this is used when wanna add more parameters to uiview initializer
    required init(numOfRows:Int) {
        self.numOfRows = numOfRows
        super.init(frame: .zero)
        createViews()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    private func setLayout(){
        
        constrain(self){
            $0.height == height
            $0.width == $0.superview!.width
        }
        
        constrain(lbWeekDay){
            $0.height == height
            $0.left == $0.superview!.left + 15
        }
        
        constrain(lbMinMax){
            $0.height == height
            $0.right == $0.superview!.right - 15
        }
        
        constrain(ivWeatherIcon, lbMinMax){
            $0.right == $1.left - 10
            $0.height == height
            $0.width == $0.height
            $0.centerY == $0.superview!.centerY
        }
        
    }
    
    override func updateConstraints() {
        setLayout()
        super.updateConstraints()
        return
    }
    
    func updateContent(list:List){
        
        ivWeatherIcon.image = UIImage(named: list.weather[0].icon)
        
        lbWeekDay.text = "\(list.date.toWeekDay())"
        
        if Locale.current.usesMetricSystem{
            let min = list.main.minC.toInt()
            let max = list.main.maxC.toInt()
            lbMinMax.text = "\(min)°C - \(max)°C"
        }else{
            let min = list.main.minF.toInt()
            let max = list.main.maxF.toInt()
            lbMinMax.text = "\(min)°F - \(max)°F"
        }
        
    }
}
