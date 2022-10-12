//
//  BusinessSection.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 14.09.22.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)){
            ForEach(businesses){business in
                // if we dont have the restaurants conforming to the identifiable property, we have to add --> id: \.self
                NavigationLink {
                    BusinessDetail(business: business)
                } label: {
                    BusinessRow(business: business)
                }

                
            }
        }
    }
}

