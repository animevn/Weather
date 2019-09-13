import UIKit
import Cartography

class CurrentWeather:UIView{
    
    let height:CGFloat = screen().y * 3.5/10 - inset * 2
    
    private var lbTemp = UILabel()
    private var lbMinMax = UILabel()
    private var lbCity = UILabel()
    private var lbWeather = UILabel()
    private var ivWeather = UIImageView()
    
    private func createViews(){
        addSubview(lbTemp)
        addSubview(lbMinMax)
        addSubview(lbCity)
        addSubview(lbWeather)
        addSubview(ivWeather)
    }
    
    private func setupViews(){
        lbTemp.textColor = .white
        lbTemp.font = .systemFont(ofSize: height * 0.5)
        lbTemp.adjustsFontSizeToFitWidth = true
        lbTemp.shadowColor = .darkGray
        
        lbMinMax.textColor = .white
        lbMinMax.font = .systemFont(ofSize: height * 0.12)
        lbMinMax.adjustsFontSizeToFitWidth = true
        lbMinMax.shadowColor = .darkGray
        
        lbWeather.textColor = .white
        lbWeather.font = .systemFont(ofSize: height * 0.12)
        lbWeather.adjustsFontSizeToFitWidth = true
        lbWeather.shadowColor = .darkGray
        
        lbCity.textColor = .white
        lbCity.font = .systemFont(ofSize: height * 0.12)
        lbCity.adjustsFontSizeToFitWidth = true
        lbCity.shadowColor = .darkGray
        lbCity.textAlignment = .right
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        constrain(lbWeather){
            $0.top == $0.superview!.top
            $0.left == $0.superview!.left + inset
            $0.height == height/5
        }
        
        constrain(lbTemp, lbWeather){
            $0.top == $1.bottom
            $0.height == height * 3/5
            $0.left == $1.left
            $0.centerY == $0.superview!.centerY
        }
        
        constrain(ivWeather, lbTemp){
            $0.centerY == $1.centerY
            $0.height == height * 2/5
            $0.width == $0.height
            $0.left == $1.right + 15
            $0.right == $0.superview!.right - 15
        }
        
        constrain(lbMinMax, lbTemp){
            $0.top == $1.bottom
            $0.left == $0.superview!.left + inset
            $0.bottom == $0.superview!.bottom
        }
        
        constrain(lbCity, lbMinMax){
            $0.centerY == $1.centerY
            $0.right == $0.superview!.right - inset
            $0.left == $1.right + inset
        }
        
    }
    
    override func updateConstraints() {
        setLayout()
        super.updateConstraints()
        return
    }
    
    func updateCurrentWeather(weatherCurrent:WeatherCurrent){
        ivWeather.image = UIImage(named: weatherCurrent.weather[0].icon)
        let textWeather = weatherCurrent.weather[0].description
        lbWeather.text = "\(textWeather.upperFirstLetter())"
        
        if Locale.current.usesMetricSystem{
            lbTemp.text = "\(weatherCurrent.main.tempC.toInt())°C"
            let max = weatherCurrent.main.maxC.toInt()
            let min = weatherCurrent.main.minC.toInt()
            lbMinMax.text = "\(min)°C - \(max)°C"
        }else{
            lbTemp.text = "\(weatherCurrent.main.tempF.toInt())°F"
            let max = weatherCurrent.main.maxF.toInt()
            let min = weatherCurrent.main.minF.toInt()
            lbMinMax.text = "\(min)°F - \(max)°F"
        }
        
    }
    
    
}
