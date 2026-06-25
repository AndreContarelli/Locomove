//
//  StopModel.swift
//  Checkin
//
//  Created by André Contarelli Lima on 24/06/26.
//

import Foundation

struct StopModel: Codable, Identifiable, Equatable {
    let cp: Int      
    let np: String
    let ed: String
    let py: Double
    let px: Double

    var id: Int { cp }

    enum CodingKeys: String, CodingKey {
        case cp, np, ed, py, px
    }
}
