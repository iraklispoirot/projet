import Foundation
import CoreLocation
import SwiftyJSON

class WebServiceController{
    
    
    //static let apiKey = "AIzaSyBKTjCw777oTmHbl2Eil1d-E_FhlVXxX7M"
    static let apiKey = "AIzaSyAwTfb_79xZABH8dZETeFIWDkvGY3TiqM0"
    static let googleMapsRadarSearchURL = URL(string: "https://maps.googleapis.com/maps/api/place/radarsearch/json?")!
    static let googleMapsSearchPlaceDetailsURL = URL(string:"https://maps.googleapis.com/maps/api/place/details/json?")!
    
    static func fetchGooglePlaces(near coordinate: CLLocationCoordinate2D, handler: @escaping ([MagasinLocation], Error?) -> Void) {
        
        let query: [String: String] = [
            "key": WebServiceController.apiKey,
            "location": "\(coordinate.latitude),\(coordinate.longitude)",
            "radius":"2000",
            "type": "department_store"
            ]
        
        let url = googleMapsRadarSearchURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                let json = JSON(data: data)
                let results = json["results"].arrayValue
                let magasinFound = results.flatMap{MagasinLocation(json: $0)}
                DispatchQueue.main.async {
                    handler(magasinFound, error)
                }
            }
        }
        task.resume()
    }
    
    
    // On every place found, search for more details with its placeId
    static func fetchGooglePlaceDetails(placeId id:String, handler: @escaping (DetailsMagasin?) -> Void) {
        
        let query: [String: String] = [
            "placeid": id,
            "key": WebServiceController.apiKey
        ]
        
        let url = googleMapsSearchPlaceDetailsURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                let json = JSON(data: data)
                let magasinFound = DetailsMagasin(json: json["result"])
                DispatchQueue.main.async {
                    handler(magasinFound)
                }
            }
        }
        task.resume()
    }
}
/*
    //// url places : https://maps.googleapis.com/maps/api/place/radarsearch/json?location=50.449801,4.848380&radius=5000&type=car_repair&key=AIzaSyAwTfb_79xZABH8dZETeFIWDkvGY3TiqM0
//// url details place : https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJUXdJMEKYwUcRLOBaaVuBRL4&key=AIzaSyAwTfb_79xZABH8dZETeFIWDkvGY3TiqM0
*/

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
