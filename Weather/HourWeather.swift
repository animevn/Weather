import UIKit
import Cartography

class HourWeather:UIView{
    
    let height:CGFloat = screen().y * 1.5/10
    var isUpdateLayout = false
    
    private var scrollView = UIScrollView()
    private var hourCells = [HourCell]()
    
    private func createViews(){
        addSubview(scrollView)
    }
    
    private func setupViews(){
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = true
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
    
    private func createLayout(){
        
        constrain(self){
            $0.height == height
            $0.width == $0.superview!.width
        }
        
        constrain(scrollView){
            $0.edges == $0.superview!.edges
        }
        
        constrain(hourCells.first!){
            $0.top == $0.superview!.top
            $0.left == $0.superview!.left
            $0.bottom == $0.superview!.bottom
        }
        
        for i in 0..<hourCells.count - 1{
            constrain(hourCells[i], hourCells[i + 1]){
                $1.left == $0.right + 5
                $1.top == $0.top
                $1.bottom == $0.bottom
            }
        }
        
        constrain(hourCells.last!){
            $0.right == $0.superview!.right - 5
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
    
    private func addCellToScrollView(weatherHourly:WeatherHourly){
        let count = weatherHourly.list.count
        (1...count).forEach{_ in
            let cell = HourCell(frame: .zero)
            hourCells.append(cell)
            scrollView.addSubview(cell)
        }
    }
    
    func createHourlyView(weatherHourly:WeatherHourly){
        addCellToScrollView(weatherHourly: weatherHourly)
    
        zip(hourCells, weatherHourly.list).forEach{
            $0.createHourCellView(list:$1)
        }
    }
}

