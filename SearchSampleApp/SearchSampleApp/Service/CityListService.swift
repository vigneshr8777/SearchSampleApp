//
//  CityListService.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation

protocol CityListServiceProtocol {
    func getCities(searchTerm: String,completion: @escaping ((Result<CitiesResponse, Error>) -> Void))
}

struct CityListService:CityListServiceProtocol {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getCities(searchTerm: String,completion: @escaping ((Result<CitiesResponse, Error>) -> Void)) {

        let requestPath = String(format: Server.baseurl, searchTerm)
        networkManager.request(requestInfo: RequestInfo(path: requestPath, parameters: nil, method: .get)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let response = try Parser<CitiesResponse>().decode(data: data)
                    completion(.success(response))
                } catch {
                    if let error = Error.init(error: error) {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
