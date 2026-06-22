//
//  LineIdentificator.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI

struct LineIdentificator: View {
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 90, height: 44)
                .cornerRadius(8)
                .foregroundStyle(Color(red: 0.39, green: 0.57, blue: 0.73)) // Alterar pra cor correta
            Text("6913-10") // Alterar pra linha correta
                .foregroundStyle(.fWhite)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    LineIdentificator()
}
