//
//  SearchCoordinator.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import Foundation
import UIKit

final class AppCoordinator {

    var navigationController: UINavigationController!

    func getSearchListController() -> UINavigationController {
        let vc = SearchViewController.prepareVC(withDependency: SearchDependency())
        self.navigationController = UINavigationController(rootViewController: vc)
        return self.navigationController
    }

}
