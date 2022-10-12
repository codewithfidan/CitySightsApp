//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 16.09.22.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading, spacing: 0){
                // Business Image
                GeometryReader(){ geo in
                    
                    let uIImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uIImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                       
                       
                }
                .ignoresSafeArea(.all, edges: .top)
                // Open / closed indicator
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? Color.black.opacity(0.7) : Color.blue.opacity(0.7))
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading)
                }
            }
            
            
            Group{
                
                // Business Name
                Text(business.name!)
                    .bold()
                    .font(.title)
                    .padding()
                
                // Loop through display address
                if business.location?.displayAddress != nil{
                    ForEach(business.location!.displayAddress!, id: \.self){address in
                        Text(address)
                            .padding(.horizontal)
                        
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0)")
                    .padding(.horizontal)
                
                Divider()
                
                // Phone
                HStack{
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                Divider()
                
                // Reviews
                HStack{
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Review", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                Divider()
                
                // Website
                HStack{
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Website", destination: URL(string: "tel:\(business.url ?? "")")!)
                    
                }.padding()
                Divider()
                
            }
            
            // Get Directions Button
            Button {
                
            } label: {
                ZStack{
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .bold()
                        .foregroundColor(.white)
                }.padding()
            }
            
        }
    }
}

//struct BusinessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDetail()
//    }
//}
