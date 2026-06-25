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

    let collapsedHeight: CGFloat = 108
    let expandedHeight: CGFloat = UIScreen.main.bounds.height * 0.45

    var body: some View {
        ZStack(alignment: .bottom) {

            Map(position: $cameraPosition) {
                UserAnnotation()

                ForEach(apiViewModel.selectedStops) { stop in
                    Annotation(stop.np.capitalized, coordinate: CLLocationCoordinate2D(latitude: stop.py, longitude: stop.px)) {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 44, height: 44)
                                .shadow(radius: 2)
                            Image(systemName: "bus.fill")
                                .font(.system(size: 17))
                                .foregroundStyle(.fSecondary)
                        }
                    }
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .ignoresSafeArea()
            .onAppear {
                locationManager.requestPermission()
            }
            .onChange(of: apiViewModel.selectedStops) {
                guard let first = apiViewModel.selectedStops.first else { return }
                withAnimation {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: first.py, longitude: first.px),
                        latitudinalMeters: 3000,
                        longitudinalMeters: 3000
                    ))
                }
            }

            VStack(spacing: 0) {
                // Drag indicator
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(.systemGray4))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .onTapGesture {
                        withAnimation(.spring()) { isExpanded.toggle() }
                    }

                // Card da linha selecionada, visível quando a sheet ta recolhida
                if let selected = apiViewModel.selectedLine, !isExpanded {
                    HStack {
                        LineIdentificator(letreiro: "\(selected.lt)-\(selected.tl)")

                        VStack(alignment: .leading, spacing: 2) {
                            Text(selected.tp.capitalized)
                                .font(.system(size: 14, weight: .medium))
                            Text(selected.ts.capitalized)
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.leading, 8)

                        Spacer()

                        Text("\(apiViewModel.selectedStops.count) paradas")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)

                        Button {
                            withAnimation(.spring()) {
                                apiViewModel.selectedLine = nil
                                apiViewModel.selectedStops = []
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 18))
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                }
                SheetView(apiViewModel: apiViewModel, isExpanded: $isExpanded)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: isExpanded ? expandedHeight : (apiViewModel.selectedLine != nil ? collapsedHeight + 50 : collapsedHeight))
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.15), radius: 10, y: -2)
            .animation(.spring(), value: isExpanded)
            .animation(.spring(), value: apiViewModel.selectedLine?.cl)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
