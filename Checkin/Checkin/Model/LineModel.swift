//
//  LineModel.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import Foundation

struct LineModel: Codable, Identifiable {
    var id: UUID = UUID()
    let cl: Int
    let tl: Int
    let tp: String
    let ts: String

    enum CodingKeys: String, CodingKey {
        case cl, tl, tp, ts  
    }
}
