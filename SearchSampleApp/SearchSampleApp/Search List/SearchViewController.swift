//
//  SearchViewController.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var viewModel: SearchViewModel!

    enum SearchViewControllerConstants {
        static let tableViewDefault: CGFloat  = 90.0
    }

    static func prepareVC(withDependency dependency:SearchListDependency) -> SearchViewController {
        let viewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let viewModel = SearchViewModel(withDependency: dependency)
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        configureSubViews()
        setupTableView()
    }

    private func configureSubViews() {
        searchButton.layer.cornerRadius = 6.0
        searchButton.layer.borderWidth = 1.0
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func setupTableView() {
        tableView.estimatedRowHeight = SearchViewControllerConstants.tableViewDefault
        tableView.register(UINib(nibName: String(describing: ListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListCell.self))
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init(frame: .zero)
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(SearchViewController.performSearchList), object: nil)
        self.perform(#selector(SearchViewController.performSearchList), with: nil, afterDelay: 0.0)
    }

    @objc func performSearchList() {
        fetchCities(searchTerm: searchBar.text ?? "")
    }

    private func fetchCities(searchTerm: String) {
        viewModel.fetchCities(searchTerm: searchTerm) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.tableView.reloadData()
                case .failure(_):
                    // TODO - handle error to show error view
                    break
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListCell.self), for: indexPath)
        if let cell = cell as? ListCell, let model = self.viewModel.getCellViewModel(atIndex:  indexPath.row) {
            cell.configureCell(withViewModel: model)
        }
        return cell
    }
}
