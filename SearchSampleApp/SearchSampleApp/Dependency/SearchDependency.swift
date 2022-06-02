//
//  SearchDependency.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation

protocol SearchListDependency {
    var service: CityListServiceProtocol { get set }
}

struct SearchDependency: SearchListDependency {
    var service: CityListServiceProtocol
    
    init(service: CityListServiceProtocol = CityListService(networkManager: NetworkManager())) {
        self.service = service
    }
}

struct MockDependency: SearchListDependency {
    var service: CityListServiceProtocol
    
    init(error: Error? = nil) {
        var service = MockListService()
        service.error = error
        self.service = service
    }
}
