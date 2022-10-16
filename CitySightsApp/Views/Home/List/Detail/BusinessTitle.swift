//
//  BusinessTitle.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 12.10.22.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading){
            // Business Name
            Text(business.name!)
                .bold()
                .font(.title)
                .foregroundColor(.black)
            
            // Loop through display address
            if business.location?.displayAddress != nil{
                ForEach(business.location!.displayAddress!, id: \.self){address in
                    Text(address)
                        .foregroundColor(.black)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0)")
                
        }
    }
}

//struct BusinessTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessTitle()
//    }
//}
