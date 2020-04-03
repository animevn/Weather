import Foundation

struct Photo:Codable{
    let id:String
    let secret:String
    let farm:Int
    let server:String
    let ispublic:Int
}

struct Photos:Codable{
    let photo:[Photo]
}

struct Flickr:Codable{
    let photos:Photos
}
