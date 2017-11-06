import Foundation
import UIKit
import SwiftyJSON

class DetailsMagasin{

    var placeid:String?
    var name:String?
    var international_phone_number:String?
    var formatted_address:String?
    var website:String?
    
    init?(json: JSON) {
        self.placeid = json["place_id"].string
        self.name = json["name"].string
        self.international_phone_number = json["international_phone_number"].string
        self.formatted_address = json["formatted_address"].string
        self.website = json["website"].string
    }
    
    func description() -> String{
        return (name ?? "no_name")  + " " + (formatted_address ?? "no_adresse") + " " + (international_phone_number ?? "no_phone")
    }
}
