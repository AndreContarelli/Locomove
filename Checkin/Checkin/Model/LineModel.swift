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
    
    init(cl: Int, tl: Int, tp: String, ts: String) {
        self.cl = cl
        self.tl = tl
        self.tp = tp
        self.ts = ts
    }
}
