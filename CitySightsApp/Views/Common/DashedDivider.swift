//
//  DashedDivider.swift
//  CitySightsApp
//
//  Created by Fidan Oruc on 17.10.22.
//

import SwiftUI

struct DashedDivider: View {
    var body: some View {
        
        GeometryReader{ geometry in
            Path{ path in
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1,dash: [5]))
            .foregroundColor(.gray)
        }.frame(height: 1)
        
        
    }
}
/*
 What is the Path type in SwiftUI?
 You can use Path to create any 2D shape to use as a view
 */

struct DashedDivider_Previews: PreviewProvider {
    static var previews: some View {
        DashedDivider()
    }
}
