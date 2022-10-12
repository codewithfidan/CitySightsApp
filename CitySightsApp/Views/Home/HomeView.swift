//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 14.09.22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness: Business? // it detects some sort of view code changes in this home view
    
    var body: some View {
        
        
        if model.restaurants.count != 0 || model.sights.count != 0{
            
            NavigationView{
                // Determine if we should show list or map
                if !isMapShowing{
                    // show list
                    
                    VStack{
                        HStack{
                            Image(systemName: "mappin")
                            Text("San Francisco")
                            Spacer()
                            Button("Switch to the Map view") {
                                self.isMapShowing = true
                            }
                            
                        }
                        Divider()
                        BusinessList()
                    }
                    .padding()
                    .navigationBarHidden(true)
                    
                }else{
                    // Show map
                    ZStack(alignment: .top){
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                
                                // Create a business detail view instance
                                // Pass in the selected business
                                BusinessDetail(business: business)
                            }
                        // Rectangle overlay
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            HStack{
                                Image(systemName: "mappin")
                                Text("San Francisco")
                                Spacer()
                                Button("Switch to the List view") {
                                    self.isMapShowing = false
                                }
                            }.padding()
                        }.padding()
                    }
                    .navigationBarHidden(true)// navigation title is specified for the child view of the navigationview. when run the app skip the if statement and first child of the navigation view is zstack
                    
                }
            }
            
            
        }else{
            // after the user has authorized us to locate them, we actually have to wait for the geolocation to work and for us to get the location update. we have to pass latitude longitude into yelp api and wait for the response to come back
            // Still waiting for data so show spinner
            ProgressView()
            //ProgressView is good to use as a placeholder while data is being returned for a view.
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
/*
 What does the Binding property do when passed as a variable to a view?
 It acts as a two way binding to the State variable in the parent view, so that the child view can modify the variable
 Bindings are good to use when a child view needs to track/modify a variable from a parent view
*/
