//
//  LineModel.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import Foundation

struct LineModel: Codable, Identifiable {
    var id: UUID = UUID()
    let cl: Int       // código interno da linha
    let lc: Bool      // é circular?
    let lt: String    // letreiro numérico ex: "8000", "6913-10"
    let sl: Int       // sentido: 1 = ida, 2 = volta
    let tl: Int       // tipo: 10 = base
    let tp: String    // terminal principal (origem)
    let ts: String    // terminal secundário (destino)

    enum CodingKeys: String, CodingKey {
        case cl, lc, lt, sl, tl, tp, ts
    }
}
