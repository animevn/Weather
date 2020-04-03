import CoreLocation

class GetLocation:NSObject{
    
    private var locationManager = CLLocationManager()
    private var coord:(Coord)->Void
    
    init(coord:@escaping (Coord)->Void) {
        self.coord = coord
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
}

extension GetLocation:CLLocationManagerDelegate{
        
    func locationManager(
        _ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status{
        case .denied:
            print("denied")
        case .notDetermined:
            print("not determined")
        case .restricted:
            print("restricted")
        default:
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let coord = locations.last?.coordinate else {return}
        DispatchQueue.main.async {[weak self] in
            self?.coord(Coord(lat: coord.latitude, lon: coord.longitude))
            self?.locationManager.stopUpdatingLocation()
        }
    }
    
}




