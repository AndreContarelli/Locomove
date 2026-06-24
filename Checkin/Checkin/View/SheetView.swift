//
//  SheetView.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI

struct SheetView: View {
    
    @State private var searchTerm: String = ""
    @StateObject var apiViewModel: APIViewModel
    @Binding var selectedDetent: PresentationDetent
    let meuToken = "0150c9a54a15dad7e7cfd8bb18e62400e680a035a2154e88a934a0ec121de94e"
    
    var body: some View {
        NavigationStack {
            if apiViewModel.busLines.isEmpty {
                VStack(spacing: 12){
                    Image(systemName: "bus")
                        .font(.system(size: 41))
                        .fontWeight(.semibold)
                        .foregroundStyle(.fSecondary)
                    Text("Nenhuma Linha Encontrada")
                        .font(.system(size: 22))
                        .foregroundStyle(Color(red: 0.33, green: 0.3, blue: 0.35))
                    Text("Pesquise alguma linha ou destino de seu ônibus")
                        .font(.system(size: 22))
                        .foregroundStyle(.fPrimary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                List(apiViewModel.busLines) { line in
                    Text(line.tp)
                }
            }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always), prompt: "Pesquisar")
        .onAppear {
            Task {
                await apiViewModel.autenticar(token: meuToken)
            }
        }
        .onChange(of: searchTerm) { _, newValue in
            withAnimation {
                selectedDetent = newValue.isEmpty ? .height(80) : .fraction(0.45)
            }
            if newValue.isEmpty { apiViewModel.busLines = [] }
        }
    }
}
