//
//  BusinessList.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 14.09.22.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders){
                // if we dont have the restaurants conforming to the identifiable property, we have to add --> id: \.self
                
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                BusinessSection(title: "Sights", businesses: model.sights)
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
