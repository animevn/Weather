import UIKit

class WeatherController: UIViewController {
    
    private var background = UIImageView()

    
    
    private func setupBackground(image:String){
        background.image = UIImage(named: image)
        background.clipsToBounds = true
        background.frame.size = view.frame.size
        view.addSubview(background)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground(image: "background")
        
    }


}

