//
//  CitySightsAppApp.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 08.09.22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(ContentModel())
        }
    }
}
