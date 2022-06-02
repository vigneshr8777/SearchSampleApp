//
//  Cities.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation

struct CitiesResponse: Codable {
    let totalResultsCount: Int
    let geonames: [Geoname]
}

struct Geoname: Codable {
    let adminCode1, lng: String?
    let geonameID: Int?
    let toponymName: String?
    let countryID: String?
    let population: Int?
    let countryCode: String?
    let name: String
    let fclName: String?
    let countryName, adminName1: String
    let fcodeName, lat: String?
    let fcode: String?

    enum CodingKeys: String, CodingKey {
        case adminCode1, lng
        case geonameID = "geonameId"
        case toponymName
        case countryID = "countryId"
        case fclName = "fclName"
        case name = "name"
        case population, countryCode, countryName, fcodeName, adminName1, lat, fcode
    }
}

extension Geoname {
    init(name: String, country: String, state: String) {
        self.name = name
        self.countryName = country
        self.adminName1 = state
        adminCode1 = nil
        lng = nil
        countryID = nil
        fclName = nil
        fcodeName = nil
        fcode = nil
        lat = nil
        geonameID = nil
        countryCode = nil
        population = nil
        toponymName = nil
    }
}
