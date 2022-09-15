//
//  Business.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 13.09.22.
//

import Foundation

class Business: Decodable, Identifiable, ObservableObject{
    
    @Published var imageData: Data?
    //we are in the struct and we have to change it to class for @Published this property
    
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    
    func  getImageData(){
        
        // Check that image url is not nil
        guard imageUrl != nil else{
            return
        }
        // Download the data for the image
        if let url = URL(string: imageUrl!){
            
            // Get a session
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    DispatchQueue.main.async {
                        // Set the image data
                        self.imageData = data!
                        // we have an error - Cannot assign to property: 'self' is immutable because we are in the struct and we have to change it to class
                    }
                }
            }
            dataTask.resume()
        }
    }
}
struct Category: Decodable{
    var alias: String?
    var title: String?
    
}
struct Coordinate: Decodable{
    var latitude: Double?
    var longitude: Double?
}
struct Location: Decodable{
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey{
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        case address1
        case address2
        case address3
        case city
        case country
        case state
        
    }
}
