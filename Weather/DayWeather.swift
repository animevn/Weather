import UIKit
import Cartography

class DayWeather:UIView{
    
    let height:CGFloat = screen().y * 5/10 - inset
    var isUpdateLayout = false
    var numOfRows:Int!
    
    private var dayCells = [DayCell]()
    
    func setNumOfRows(weatherHourly:WeatherHourly){
        numOfRows = weatherHourly.listDaily.count
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    private func createLayout(){
        constrain(self){
            $0.height == height
        }
        
        constrain(dayCells.first!){
            $0.top == $0.superview!.top
            $0.left == $0.superview!.left
            $0.height == height/CGFloat(numOfRows)
        }
        
        for i in 0..<(dayCells.count - 1){
            constrain(dayCells[i], dayCells[i + 1]){
                $1.top == $0.bottom
                $0.left == $0.superview!.left
                $0.height == height/CGFloat(numOfRows)
            }
        }
        
        constrain(dayCells.last!){
            $0.bottom == $0.superview!.bottom
        }
    }
    
    override func updateConstraints() {
        if !isUpdateLayout{
            super.updateConstraints()
            return
        }else{
            createLayout()
            super.updateConstraints()
            isUpdateLayout = false
            return
        }
    }
    
    private func createRows(){
        (1...numOfRows).forEach{_ in
            let cell = DayCell(numOfRows: numOfRows)
            dayCells.append(cell)
            addSubview(cell)
        }
    }
    
    func createDailyForecastViews(weatherHourly:WeatherHourly){
        createRows()
        zip(dayCells, weatherHourly.listDaily).forEach{
            $0.updateContent(list:$1)
        }
    }
}
