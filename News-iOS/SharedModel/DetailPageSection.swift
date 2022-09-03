//
//  DetailPageSection.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 13.08.2022.
//

import UIKit

//MARK: - Detail page item

struct TableViewItem {
    var createdCell: () -> UITableViewCell
}

//MARK: - Detail page section

enum TableViewSection {
    case overview(_ items: [TableViewItem])
    case pagefeed(_ items: [PlanetaryModel])
}
