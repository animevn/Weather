import UIKit

class WeatherController: UIViewController{
    
    private var background = UIImageView()
    private var blurrView = UIImageView()
    private var scrollView = UIScrollView()
    
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
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WelcomeView did load")
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














