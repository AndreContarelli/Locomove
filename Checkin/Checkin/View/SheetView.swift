//
//  SheetView.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//
import SwiftUI

struct SheetView: View {
    
    @State private var searchTerm: String = ""
    @ObservedObject var apiViewModel: APIViewModel
    @Binding var isExpanded: Bool
    
    let meuToken = "0150c9a54a15dad7e7cfd8bb18e62400e680a035a2154e88a934a0ec121de94e" // sei que preciso esconder isso, to descobrindo como ainda :)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Pesquisar linha ou destino", text: $searchTerm, onEditingChanged: { isEditing in
                    if isEditing {
                        withAnimation(.spring()) { isExpanded = true }
                    }
                })
                if !searchTerm.isEmpty {
                    Button {
                        searchTerm = ""
                        apiViewModel.busLines = []
                        withAnimation(.spring()) { isExpanded = false }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            // Conteudo só quando expandido
            if isExpanded {
                Divider()
                
                if apiViewModel.busLines.isEmpty {
                    VStack() {
                        Image(systemName: "bus")
                            .font(.system(size: 41, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 12)
                        Text("Nenhuma linha encontrada")
                            .font(.system(size: 22))
                            .foregroundStyle(.fSecondary)
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                            .foregroundStyle(.fPrimary)
                        //                            .padding(.bottom, 8)
                        Text("Pesquise alguma linha ou destino do seu ônibus")
                            .font(.system(size: 22))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                            .foregroundStyle(.fSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    List(apiViewModel.busLines) { line in
                        LineCard(line: line, apiViewModel: apiViewModel)
                            .listRowInsets(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .onChange(of: apiViewModel.selectedLine?.cl) {
                        withAnimation(.spring()) { isExpanded = false }
                    }
                }
            }
        }
        .onChange(of: searchTerm) { _, newValue in
            withAnimation(.spring()) {
                isExpanded = newValue.isEmpty ? false : true
            }
            if newValue.isEmpty {
                apiViewModel.busLines = []
            } else if newValue.count >= 2 {
                Task { await apiViewModel.fetch(termo: newValue) }
            }
        }
        .onAppear {
            Task { await apiViewModel.autenticar(token: meuToken) }
        }
    }
}
