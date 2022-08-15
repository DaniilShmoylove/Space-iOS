//
//  DetailPageSection.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 13.08.2022.
//

import UIKit

//MARK: - Detail page item

struct DetailPageItem {
    var createdCell: () -> UITableViewCell
}

//MARK: - Detail page section

enum DetailPageSection {
    case overview(_ items: [DetailPageItem])
    case pagefeed(header: String, _ items: [PlanetaryModel])
}
