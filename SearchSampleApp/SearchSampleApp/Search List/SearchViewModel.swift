//
//  SearchViewModel.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation

final class SearchViewModel  {

    private let service: CityListServiceProtocol
    typealias CellViewModel = ListCell.ViewModel
    private var cellViewModels: [CellViewModel] = []

    init(withDependency dependency:SearchListDependency) {
        self.service = dependency.service
    }

    func numberOfItems() ->Int {
        return cellViewModels.count
    }

    func getCellViewModel(atIndex index:Int) -> ListCellViewModel? {
        guard index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }

    func fetchCities(searchTerm: String,completion: @escaping ((Result<Bool, Error>) -> Void)) {
        self.service.getCities(searchTerm: searchTerm) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.handleSuccess(response: response)
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func handleSuccess(response: CitiesResponse) {
        let viewModels = response.geonames.map { (model) -> CellViewModel in
            return CellViewModel(geoName: model)
        }
        self.cellViewModels = viewModels
    }
}
