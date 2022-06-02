//
//  ListCell.swift
//  SearchSampleApp
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//

import UIKit

protocol ListCellViewModel {
    var cityName: String { get }
    var state: String { get }
    var country: String { get }
}

final class ListCell: UITableViewCell {

    struct ViewModel: ListCellViewModel {
        var cityName: String
        var state: String
        var country: String
    }

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var countryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        cityName.font = UIFont.boldSystemFont(ofSize: 14.0)
        stateName.textColor = UIColor.lightGray
        countryName.textColor = UIColor.lightGray
    }
}

extension ListCell {
    
    func configureCell(withViewModel viewModel: ListCellViewModel) {
        self.cityName.text = viewModel.cityName
        self.stateName.text = viewModel.state
        self.countryName.text = viewModel.country
    }
}
extension ListCell.ViewModel {

    init(geoName: Geoname) {
        self.cityName = geoName.name
        self.country = geoName.countryName
        self.state = geoName.adminName1
    }
}

