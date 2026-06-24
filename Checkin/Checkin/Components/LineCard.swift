//
//  LineCard.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import SwiftUI

struct LineCard: View {
    let line: LineModel
    @ObservedObject var apiViewModel: APIViewModel

    @State private var totalParadas: Int? = nil

    var body: some View {
        HStack(spacing: 0) {
            LineIdentificator(letreiro: "\(line.lt)-\(line.tl)")

            VStack(alignment: .leading, spacing: 2) {
                Text(line.tp.capitalized)
                    .font(.system(size: 16, weight: .medium))
                Text(line.ts.capitalized)
                    .font(.system(size: 16, weight: .medium))
            }
            .padding(.leading, 8)

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                if let total = totalParadas {
                    Text("\(total) paradas")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                } else {
                    ProgressView()
                        .scaleEffect(0.7)
                }
                Spacer()
            }
        }
        .padding(.vertical, 4)
        .task {
            totalParadas = await apiViewModel.fetchParadas(codigoLinha: line.cl)
        }
    }
}
