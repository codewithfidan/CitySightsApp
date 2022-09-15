//
//  BusinessSectionHeader.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 14.09.22.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                
            Text(title)
                .font(.headline)
                .padding(.bottom)
        }
        
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "Restaurants")
    }
}
