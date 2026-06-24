//
//  StopModel.swift
//  Checkin
//
//  Created by André Contarelli Lima on 24/06/26.
//

import Foundation

struct StopModel: Codable, Identifiable {
    let cp: Int      
    let np: String
    let ed: String

    var id: Int { cp }

    enum CodingKeys: String, CodingKey {
        case cp, np, ed
    }
}
