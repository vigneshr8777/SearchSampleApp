//
//  MockListService.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation

struct MockListService: CityListServiceProtocol {
    
    private var response: CitiesResponse?
    var error: Error?
    
    init() {
        setupResponse()
    }
    
    private mutating func setupResponse() {
        let geoNames1 = Geoname(name: "test", country: "country", state: "state")
        let geoNames2 = Geoname(name: "test", country: "country", state: "state")
        let geoNames3 = Geoname(name: "test", country: "country", state: "state")
        response = CitiesResponse(totalResultsCount: 10, geonames: [geoNames1, geoNames2, geoNames3])
    }
    
    func getCities(searchTerm: String, completion: @escaping ((Result<CitiesResponse, Error>) -> Void)) {
        if let error = error {
            completion(.failure(error))
        } else {
            if let response = response {
                completion(.success(response))
            }
        }
    }
}
