import Foundation
import CoreLocation
import SwiftyJSON

class MagasinLocation{
    
    
    var location:CLLocationCoordinate2D
    var id:String
    
    init?(json: JSON) {
        guard let lat = json["geometry"]["location"]["lat"].double, let lng = json["geometry"]["location"]["lng"].double, let id = json["place_id"].string
            else{return nil}
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.id = id
    }
    
}
