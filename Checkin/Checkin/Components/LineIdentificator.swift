//
//  LineIdentificator.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI

struct LineIdentificator: View {
    let letreiro: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 90, height: 44)
                .foregroundStyle(Color(red: 0.39, green: 0.57, blue: 0.73))
            Text(letreiro)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.system(size: 15))
        }
    }
}

#Preview {
    LineIdentificator(letreiro: "bla")
}
