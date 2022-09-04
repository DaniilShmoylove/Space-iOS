//
//  DetailPageDataSource.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 20.08.2022.
//

import UIKit

final class DetailPageDataSource: NSObject {
    
    //MARK: - TableView sections
    
    var tableViewSections = [TableViewSection]()
}

extension DetailPageDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewSections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch self.tableViewSections[section] {
        case .overview(let data):
            return data.count
        case .pagefeed(let data):
            return data.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch self.tableViewSections[indexPath.section] {
            
            /* Static overview */
            
        case .overview(let data):
            return data[indexPath.row].createdCell()
            
            /* Page feed */
            
        case .pagefeed(let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PlanetaryDefaultTableViewCell.id,
                for: indexPath
            ) as! PlanetaryDefaultTableViewCell
            cell.configure(with: data[indexPath.row])
            cell.backgroundColor = .systemBackground
            return cell
        }
    }
}
