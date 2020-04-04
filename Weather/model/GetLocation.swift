import CoreLocation

class GetLocation:NSObject, CLLocationManagerDelegate{
    
    private var locationManager = CLLocationManager()
    private var coord:(Coord)->Void
    
    init(coord:@escaping (Coord)->Void) {
        self.coord = coord
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let coord = locations.last?.coordinate else {return}
        DispatchQueue.main.async {[weak self] in
            self?.coord(Coord(lat: coord.latitude, lon: coord.longitude))
            self?.locationManager.stopUpdatingLocation()
        }
    }
}





