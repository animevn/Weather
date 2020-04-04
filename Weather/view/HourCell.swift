import UIKit
import Cartography

class HourCell:UIView{
    
    let height:CGFloat = screen().y * 1.5 / 10 / 5
    
    private var lbDay = UILabel()
    private var lbHour = UILabel()
    private var ivWeather = UIImageView()
    private var lbMinMax = UILabel()
    
    private func createViews(){
        addSubview(lbDay)
        addSubview(lbHour)
        addSubview(ivWeather)
        addSubview(lbMinMax)
    }
    
    private func setupViews(){
        
        lbDay.textColor = .white
        lbDay.shadowColor = .darkGray
        lbDay.adjustsFontSizeToFitWidth = true
        lbDay.font = .systemFont(ofSize: height * 0.8)
        lbDay.textAlignment = .center
        
        lbHour.textColor = .white
        lbHour.shadowColor = .darkGray
        lbHour.adjustsFontSizeToFitWidth = true
        lbHour.font = .systemFont(ofSize: height * 0.8)
        lbHour.textAlignment = .center
        
        lbMinMax.textColor = .white
        lbMinMax.shadowColor = .darkGray
        lbMinMax.adjustsFontSizeToFitWidth = true
        lbMinMax.font = .systemFont(ofSize: height * 0.8)
        lbMinMax.textAlignment = .center
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLayout(){
        
        constrain(self){
            $0.height == height * 5
            $0.width == $0.height
            $0.centerY == $0.superview!.centerY
        }
        
        constrain(lbDay){
            $0.height == height
            $0.top == $0.superview!.top
            $0.centerX == $0.superview!.centerX
        }
        
        constrain(lbHour, lbDay){
            $0.height == height
            $0.top == $1.bottom
            $0.centerX == $0.superview!.centerX
        }
        
        constrain(ivWeather, lbHour){
            $0.height == height * 2
            $0.width == $0.height
            $0.top == $1.bottom
            $0.centerX == $0.superview!.centerX
        }
        
        constrain(lbMinMax, ivWeather){
            $0.height == height
            $0.top == $1.bottom
            $0.centerX == $0.superview!.centerX
            $0.bottom == $0.superview!.bottom
        }
        
    }
    
    override func updateConstraints() {
        createLayout()
        super.updateConstraints()
        return
    }
    
    func createHourCellView(list:List){
        if let weather = list.weather.first{
            ivWeather.image = UIImage(named: weather.icon)
        }
        
        lbDay.text = "\(list.dayOfMonth)"
        lbHour.text = "\(list.hour)"
        
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
