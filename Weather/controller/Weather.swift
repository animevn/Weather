import UIKit
import Cartography

class WeatherController: UIViewController, UIScrollViewDelegate{
    
    private var background = UIImageView()
    private var blurView = UIImageView()
    private var scrollView = UIScrollView()
    
    private var currentWeather = CurrentWeather(frame: .zero)
    private var hourWeather = HourWeather(frame: .zero)
    private var dayWeather = DayWeather(frame: .zero)
    
    private var manager = WeatherManager()
    
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
    
    private func setupBlurView(){
        blurView.clipsToBounds = true
        blurView.frame.size = view.frame.size
        blurView.contentMode = .scaleAspectFill
        view.addSubview(blurView)
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
    
    private func getBlurEffect()->UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    private func setupBlurEffectToView(image:UIImage?){
        guard let image = image else {return}
        background.image = image
        blurView.image = image
        blurView.addSubview(getBlurEffect())
        blurView.alpha = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let threshold = screen().y/2
        blurView.alpha = min(1, offset/threshold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WelcomeView did load")
        setupBackground(image: Constants.image)
        setupBlurView()
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("WelcomeView will appear")
        initLayouts()
        setupBlurEffectToView(image: UIImage(named: Constants.image))
        
        manager.updateWeather(
            updateCurrent: {[weak self] weatherCurrent in
            guard let weatherCurrent = weatherCurrent else {return}
            self?.currentWeather.updateCurrentWeather(weatherCurrent: weatherCurrent)
            return
        }, updateHour: {[weak self] weatherHour in
            guard let weatherHour = weatherHour else {return}
            self?.hourWeather.isUpdateLayout = true
            self?.hourWeather.createHourlyView(weatherHour: weatherHour)
            
            self?.dayWeather.isUpdateLayout = true
            self?.dayWeather.numOfRows = CGFloat(weatherHour.listDaily.count)
            self?.dayWeather.createWeatherDay(weatherHour: weatherHour)
            return
        })
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
















