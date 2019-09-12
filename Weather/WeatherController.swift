import UIKit
import Cartography

class WeatherController: UIViewController {
    
    private var background = UIImageView()
    private var blurrView = UIImageView()
    private var scrollView = UIScrollView()
    private var location:GetLocation?
    
    private var currentWeather = CurrentWeather(frame: .zero)
    private var dayWeather = DayWeather(frame: .zero)
    private var hourWeather = HourWeather(frame: .zero)
    
    
    private func setupBackground(image:String){
        background.image = UIImage(named: image)
        background.clipsToBounds = true
        background.frame.size = view.frame.size
        view.addSubview(background)
    }
    
    private func setupBlurrView(){
        blurrView.clipsToBounds = true
        blurrView.frame.size = view.frame.size
        view.addSubview(blurrView)
    }
    
    private func setupScrollView(){
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.addSubview(currentWeather)
        scrollView.addSubview(dayWeather)
        scrollView.addSubview(hourWeather)
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground(image: "default")
        setupBlurrView()
        setupScrollView()
    }
    
    private func createBlurEffect()->UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    private func setupBlurrEffectToView(image:UIImage?){
        guard let image = image else {return}
        background.image = image
        blurrView.image = image
        blurrView.addSubview(createBlurEffect())
        blurrView.alpha = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let threshold = screen().y/2
        blurrView.alpha = min(1 , offset/threshold)
    }
    
    private func setLayout(){
        
        let currentWeatherInset = screen().y - currentWeather.height - inset
        
        constrain(scrollView){
            $0.width == $0.superview!.width
            $0.top == $0.superview!.top + screen().headY
            $0.bottom == $0.superview!.bottom - screen().bottomY
        }
        
        constrain(currentWeather){
            $0.width == $0.superview!.width
            $0.top == $0.superview!.top + currentWeatherInset
            $0.height == currentWeather.height
        }
        
        constrain(hourWeather, currentWeather){
            $0.top == $1.bottom + inset
            $0.width == $1.width
            $0.height == hourWeather.height
        }
        
        constrain(dayWeather, hourWeather){
            $0.top == $1.bottom + inset
            $0.bottom == $0.superview!.bottom - inset
            $0.width == $1.width
            $0.height == dayWeather.height
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        setLayout()
        setupBlurrEffectToView(image: UIImage(named: "default"))
        
        
        location = GetLocation{ coord in
//            let flickr = GetFlickr()
//            flickr.getData(coord: coord, completion: {
//                print($0!)
//            })
            let getWeather = GetWeather()
            getWeather.getHourly(coord: coord, completion: {
                print($0!.listDaily)
            })
        }
    }

}

extension WeatherController:UIScrollViewDelegate{
    
    
}
