//
//  ResortModel.swift
//  SnowSeeker
//
//  Created by Esben Viskum on 02/06/2021.
//

import Foundation
import FileManagerExtension

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.readJSONsimple("resorts.json")
    static let example = allResorts[0]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
