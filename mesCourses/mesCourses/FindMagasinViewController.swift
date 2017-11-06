
import Foundation
import UIKit
import CoreLocation
import MapKit

class FindMagasinViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: IBOutlet
 
    @IBOutlet weak var mapNearestMagasins: MKMapView!
    @IBOutlet weak var selectedMagasinNameLabel: UILabel!
    @IBOutlet weak var selectedMagasinAdressLabel: UILabel!
    @IBOutlet weak var selectedMagasinPhoneLabel: UILabel!

    // MARK: Init
    let locationManager = CLLocationManager()
    var magasins:[MagasinLocation] = []
    var allMagasinsWithDetails:[DetailsMagasin] = []
    var selectedMagasin:DetailsMagasin!
    var lastUserLocationFound: CLLocation?
    
    
    // MARK: APP Manager
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self

        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapNearestMagasins.delegate = self
        self.mapNearestMagasins.mapType = MKMapType.standard
        self.mapNearestMagasins.clearsContextBeforeDrawing = true
        self.mapNearestMagasins.showsUserLocation = true
    }
    
    func clearFields()
    {
        selectedMagasinNameLabel.text   = ""
        selectedMagasinAdressLabel.text = ""
        selectedMagasinPhoneLabel.text  = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mapNearestMagasins.clearsContextBeforeDrawing = true
        fetchAllDetailsForMagasinsFound()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: MAP Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {


        let newLocation = locations.first!

        if let lastLocationFound = lastUserLocationFound{
            
            if lastLocationFound.distance(from: newLocation) > 5000{
                findNearestMagasin(fromCoordinate: newLocation.coordinate)
            }
            
        }else{
            resetLabelsForPlaceDetails()
            findNearestMagasin(fromCoordinate: newLocation.coordinate)
        }
        self.lastUserLocationFound = newLocation
       
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let placeId = ""+(view.annotation?.title!)!
        
        WebServiceController.fetchGooglePlaceDetails(placeId: placeId){ placeDetails in
            guard let placeDetails = placeDetails else{
                print("Place details is nil.....")
                return
            }
            self.selectedMagasin = placeDetails
            self.displayPlaceDetail(place: placeDetails)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }else{
            let pinId = "myPin"
            var pinView:MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinId) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                pinView = dequeuedView
                
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinId)
            }
            return pinView
        }
    }

    // Find nearest magasin form the user's position
    func findNearestMagasin(fromCoordinate coord:CLLocationCoordinate2D){

        WebServiceController.fetchGooglePlaces(near: CLLocationCoordinate2D(latitude: coord.latitude,  longitude: coord.longitude)){
            (magasinFound, error) in

            if let error = error{
                self.presentAlert(withError: error)
            }
            self.mapNearestMagasins.removeAnnotations(self.mapNearestMagasins.annotations)
            self.magasins = magasinFound
            self.addPins(forMagasins: magasinFound)
        }
    }
    
    func addPins(forMagasins magasins:[MagasinLocation]){
        var count = 60
        if self.magasins.count < count {
            count = self.magasins.count
        }
       
        for i in 0 ..< count
        {
            let pin = MKPointAnnotation()
            pin.coordinate = magasins[i].location
            pin.title = magasins[i].id
            mapNearestMagasins.addAnnotation(pin)
            
        }
        let allAnnotations = mapNearestMagasins.annotations
        mapNearestMagasins.showAnnotations(allAnnotations, animated: true)
    }
    
    
    
    // MARK: Places Manager
    
    //get details for magasins with place_id
    func fetchAllDetailsForMagasinsFound() {
        var count = 60
        if self.magasins.count < count {
            count = self.magasins.count
        }
        
        for i in 0 ..< count
        {
            WebServiceController.fetchGooglePlaceDetails(placeId: magasins[i].id){ placeDetails in
                guard let placeDetails = placeDetails else{
                    print("Place details is nil.....")
                    return
                }
                self.allMagasinsWithDetails.append(placeDetails)
            }
        }
        
    }
    
    func displayPlaceDetail(place:DetailsMagasin){
        self.selectedMagasinNameLabel?.text = place.name
        self.selectedMagasinAdressLabel?.text = place.formatted_address
        self.selectedMagasinPhoneLabel?.text = place.international_phone_number
     
    }
    
    func resetLabelsForPlaceDetails(){
        self.selectedMagasinNameLabel?.text = ""
        self.selectedMagasinAdressLabel?.text = ""
        self.selectedMagasinPhoneLabel?.text = ""
   
    }
    // send segue with info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /*
        if (segue.identifier == " ... ") {
            let vc = segue.destination as! ViewController
            vc.data = self.data
        }
       */
    }
    
    
}
