//
//  BusinessRow.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 15.09.22.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    // because we are waiting on imageData property
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                
                // Image
                let uIImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uIImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                    
                
                // Name and distance
                VStack(alignment: .leading){
                    Text(business.name ?? "")
                        .bold()
                        .lineLimit(1)
                        //.multilineTextAlignment(.leading)
                        
                    Text(String(format: "%.1f km away", (business.distance ?? 0)/1000 ))//distance is double with meter
                        .font(.caption)
                    // %.1f - one decimal place
                     
                }
                
                Spacer()
                
                // Star rating and number of reviews
                VStack(alignment: .leading){
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            Divider()
        }.foregroundColor(.black)
        
    }
}

//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
