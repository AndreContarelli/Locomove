//
//  ContentView.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var isShowingSheet: Bool = true
    
    @StateObject var apiViewModel = APIViewModel()
    
    @State private var sheetSize: PresentationDetent = .fraction(0.25)
    
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .onAppear {
            locationManager.requestPermission()
        }
        .sheet(isPresented: $isShowingSheet) {
            SheetView(apiViewModel: apiViewModel)
                .presentationDetents([.height(332), .fraction(0.15)])
                .presentationDragIndicator(.visible)

        }
        
    }
}

#Preview {
    ContentView()
}
