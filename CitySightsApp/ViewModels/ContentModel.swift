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
    
    override init(){
        
        
        // Init method of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        // we assign it to the content model = self is the keyword to assign  this instance of the content  model as the delegate of the location manager. we have to conform CLLocationManagerDelegate, NSObject protocol
        
        
        
        //how we are going to detect when the user has granted permission. when the user taps on one of those buttons in the permission dialog and core location manager is going to fire this method. content model is going to delegate of the location manager and location manager notify the content model
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
        
        // Start gelocating the user, after we get permission
        //locationManager.startUpdatingLocation()  // this methot is not going to do anything unless he user has granted permission from this step
    }
    
    // MARK: - Location Manager Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
      
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
        print(locations.first ?? "no location")
        
        // Stop requesting the location after we get it once
        locationManager.stopUpdatingLocation()
    }
}
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
