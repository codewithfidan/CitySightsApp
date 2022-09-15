//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 11.09.22.
//

import Foundation
import CoreLocation // get the user location


class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    override init(){
        
        
        // Init method of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        // we assign it to the content model = self is the keyword to assign  this instance of the content  model as the delegate of the location manager. we have to conform CLLocationManagerDelegate, NSObject protocol
        
        
        
        //how we are going to detect when the user has granted permission. when the user taps on one of those buttons in the permission dialog and core location manager is going to fire this method. content model is going to delegate of the location manager and location manager notify the content model
        
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: - Location Manager Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse{
            // We have permission
            
            // Start gelocating the user, after we get permission
            locationManager.startUpdatingLocation()  // this methot is not going to do anything unless he user has granted permission from this step
            
        }else if locationManager.authorizationStatus == .denied{
            // We dont have permission
            
            
        }
    }
    // this method keeps firing and giving us the current location. when they location changes/or not
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        // Gives us the location of the user
        let  userLocation = locations.first
        //print(locations.first ?? "no location")
        if userLocation != nil {
            // we have a location
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // If we have the  coordinates of the user, send into  Yelp API
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
        }
        
    }
    
    // MARK: - Yelp API methods
    
    func  getBusinesses(category: String, location: CLLocation){
        
        
        /*
         let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
         
         let url = URL(string: urlString)
         
         */
        // Create URL
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        // means url != nil
        if let url = url {
            
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                // Check that  there is not an error
                if error == nil{
                    do{
                        // Parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Sort businesses
                        var businesses = result.businesses // use everywhere sorthed array
                        businesses.sort { b1, b2 in
                            // you have to return true or false. if return true b1 should be in front of b2, false- b2 comes first
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call the getImageData function of the business
                        for b in businesses{
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            
                            // Assign results to the appropriate property
                            switch category {
                            case Constants.restaurantsKey:
                                self.restaurants = businesses //result.businesses
                            case Constants.sightsKey:
                                self.sights = businesses //result.businesses
                            default:
                                break
                            }
                        } 
                    }catch{
                        print(error)
                    }
                    
                    
                    //print(response) //po response Status Code: 200 == successful
                }
            }
            // Start the data task
            dataTask.resume()
        }
    }
}
//print(locations.first ?? "no location")
// Make sure to add a key (ex. 'Privacy - Location When In use ...') to your Info.plist to be able to request location from users

// How do you track if a user has granted location permissions? Make sure to review the process of working with CLLocationManager, such as assigning the content model as the delegate of the location manager using NSObject
/*
 how we are going to detect when the user has granted permission. when the user taps on one of those buttons in the permission dialog and core location manager is going to fire this method. content model is going to delegate of the location manager and location manager notify the content model
 
 // Request permission from the user
 locationManager.requestWhenInUseAuthorization()
 */
// .requestAlwaysAuthorization() --> you need to geo locate the user in the background, even if they are not using the app
// .requestWhenInUseAuthorization() --> if you only need the user location when they are using your app
/*
 
 locationManager.delegate = self
 // we assign it to the content model = self is the keyword to assign  this instance of the content  model as the delegate of the location manager.it allow us this class to be assigned s a delegate to the location manager. we have to conform CLLocationManagerDelegate protocol and conforming this protocol. when you try to conform to this protocol you get an error, because only NSObjects can conform this protocol.
 what is NSObject --> we know that instance of classes is object. in the objective-c objects known as NSObjects and CoreLocation framework was designed to build to work those objective-c classes. NSObjects is the root class of objective-c.
 and we get an error in init() method because it has own initialization method and we declare our init method it is actually conflicting with NSObject init() method. we have to use override keyword to say instead of calling init() method
 and inside init() method we are going to call super, super -- refers to the parent class, super references NSObjects.
 super.init() - we are going to call the init method of this init object before running our own custom code. we are calling any initialization code in NSObject first and then we are running our own custom init method
 we have class contentModel is a subclass of NSObject
 
 */
// default - CLAuthorizationStatus.notDetermined -- never been asked for permission to relocate yet,  CLAuthorizationStatus.restricted -- in the setting when location services turned off for this app and telling the user go to ios settings....
/*
 you can use in the debug to know authorizationStatus
 po locationManager.authorizationStatus == CLAuthorizationStatus.notDetermined
 po locationManager.authorizationStatus.rawValue (0,1,2,3,4)
 allow once - 4
 */
/*
 // Assign results to the appropriate property
if category == Constants.restaurantsKey{
    self.restaurants = result.businesses
}else if category == Constants.sightsKey{
    self.sights = result.businesses
}
||
 A switch statement can be useful in place of a bunch of if, else if, statements, especially if you're checking multiple cases/conditions.
switch category {
case Constants.restaurantsKey:
    self.restaurants = result.businesses
case Constants.sightsKey:
    self.sights = result.businesses
default:
    break
}
 */
