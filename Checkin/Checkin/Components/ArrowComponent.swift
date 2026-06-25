//
//  ArrowComponent.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI
import MapKit

struct ArrowComponent: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 44, height: 44)
                .cornerRadius(8)
                .foregroundStyle(.bPrimary)
            
            Image(systemName: "location")
                .font(.system(size: 20))
        }
        .onTapGesture {
            MapUserLocationButton()
        }
    }
}

#Preview {
    ArrowComponent()
}
