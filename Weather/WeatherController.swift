import UIKit

class WeatherController: UIViewController {
    
    private var background = UIImageView()
    private var location:GetLocation?
    
    
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

    override func viewWillAppear(_ animated: Bool) {
        location = GetLocation{ coord in
            let flickr = GetFlickr()
            flickr.getData(coord: coord, completion: { data in
                let string = String(data: data, encoding: .utf8)
                print(string!)
            })
        }
    }

}

