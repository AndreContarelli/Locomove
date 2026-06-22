//
//  LineCard.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI

struct LineCard: View {
    var body: some View {
        HStack(spacing: 0){
            
            LineIdentificator()
            
            VStack(alignment: .leading){
                
                Text("Itaim Bibi") // Bairro
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                Text("Term. Varginha") // Terminal
                    .font(.system(size: 16))
                    .fontWeight(.medium)
            }
            .padding(.leading, 8)
        
            VStack(alignment: .trailing) {
                
                Text("82 paradas") // Nuemero de paradas
                    .font(.system(size: 12))
                Image(systemName: "arrow.clockwise.circle")
                    .foregroundStyle(.cRed)
            }
            .padding(.leading, 87)
        }
    }
}

#Preview {
    LineCard()
}
