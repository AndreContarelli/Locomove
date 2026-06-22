//
//  PointIdentificator.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI

struct PointIdentificator: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Term. Varginha")
                .font(.system(size: 16))
                .fontWeight(.medium)
            Text("Av. Paulo Guiler Reimberg, 13")
                .font(.system(size: 14))
                .foregroundStyle(.fPrimary)
        }
    }
}

#Preview {
    PointIdentificator()
}
