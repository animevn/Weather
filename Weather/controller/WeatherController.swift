import UIKit
import Cartography

class WeatherController: UIViewController{
    
    private var background = UIImageView()
    private var blurrView = UIImageView()
    private var scrollView = UIScrollView()
    
    private var currentWeather = CurrentWeather(frame: .zero)
    private var hourWeather = HourWeather(frame: .zero)
    private var dayWeather = DayWeather(frame: .zero)
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    private func setupBackground(image:String){
        background.image = UIImage(named: image)
        background.clipsToBounds = true
        background.frame.size = view.frame.size
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
    }
    
    private func setupBlurrView(){
        blurrView.clipsToBounds = true
        blurrView.frame.size = view.frame.size
        blurrView.contentMode = .scaleAspectFill
        view.addSubview(blurrView)
    }
    
    private func setupScrollView(){
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.addSubview(currentWeather)
        scrollView.addSubview(hourWeather)
        scrollView.addSubview(dayWeather)
        view.addSubview(scrollView)
    }
    
    private func initLayouts(){
        
        let currentWeatherTopInset = screen().y - currentWeather.height - Constants.inset
        
        constrain(scrollView){
            $0.width == $0.superview!.width
            $0.top == $0.superview!.top + screen().headY
            $0.bottom == $0.superview!.bottom - screen().bottomY
        }
        
        constrain(currentWeather){
            $0.width == $0.superview!.width
            $0.top == $0.superview!.top + currentWeatherTopInset
            $0.height == currentWeather.height
        }
        
        constrain(hourWeather, currentWeather){
            $0.top == $1.bottom + Constants.inset
            $0.width == $1.width
            $0.height == hourWeather.height
        }
        
        constrain(dayWeather, hourWeather){
            $0.top == $1.bottom + Constants.inset
            $0.bottom == $0.superview!.bottom - Constants.inset
            $0.width == $1.width
            $0.height == dayWeather.height
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WelcomeView did load")
        setupBackground(image: Constants.image)
        setupBlurrView()
        setupScrollView()
        initLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("WelcomeView will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("WelcomeView did appear")
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("WelcomeView will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("WelcomeView did appear")
    }
    
}

extension WeatherController:UIScrollViewDelegate{
    
    
    
}














