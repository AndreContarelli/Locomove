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
    @StateObject var apiViewModel = APIViewModel()

    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isExpanded: Bool = false

    let collapsedHeight: CGFloat = 80
    let expandedHeight: CGFloat = UIScreen.main.bounds.height * 0.45

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $cameraPosition) {
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .ignoresSafeArea()
            .onAppear {
                locationManager.requestPermission()
            }
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(.systemGray4))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }

                SheetView(apiViewModel: apiViewModel, isExpanded: $isExpanded)
            }
            .frame(maxWidth: .infinity)
            .frame(height: isExpanded ? expandedHeight : collapsedHeight)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.15), radius: 10, y: -2)
            .padding(.horizontal, 0)
            .animation(.spring(), value: isExpanded)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
