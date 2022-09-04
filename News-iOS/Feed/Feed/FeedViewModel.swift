//
//  FeedViewModel.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 20.08.2022.
//

import UIKit

//MARK: - FeedViewModelDelegate

protocol FeedViewModelDelegate: AnyObject {
    func detailPageDidSelect(data: PlanetaryModel)
    func loadMoreDidBottomScroll()
}

final class FeedViewModel: NSObject {
    
    //MARK: - Display data
    
    var data = [FeedCellModel]()
    
    //MARK: - Delegate
    
    weak var delegate: FeedViewModelDelegate?
    
    //MARK: - Data service
    
    private var dataService = DataService.shared
    
    //MARK: - Init
    
    init(delegate: FeedViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
}

//MARK: - UITableViewDataSource

extension FeedViewModel: UITableViewDataSource {
    
    /* Number of sections */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    /* Number of rows in section */
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch self.data[section] {
        case .pictureOfTheDay(let data): return data.count
        }
    }
    
    /* Cell for row at */
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch self.data[indexPath.section] {
            
            //MARK: Picture of the day cell
            
        case .pictureOfTheDay(let data):
            switch data[indexPath.row].cellType {
                
                /* Large cell type */
                
            case .large:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: PlanetaryLargeTableViewCell.id,
                    for: indexPath
                ) as! PlanetaryLargeTableViewCell
                cell.selectionStyle = .none
                cell.backgroundColor = . systemGray6
                cell.configure(with: data[indexPath.row])
                return cell
                
                /* Default cell type */
                
            case .default:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: PlanetaryDefaultTableViewCell.id,
                    for: indexPath
                ) as! PlanetaryDefaultTableViewCell
                cell.selectionStyle = .none
                cell.backgroundColor = . systemGray6
                cell.configure(with: data[indexPath.row])
                return cell
            }
        }
    }
}

//MARK: - UITableViewDelegate

extension FeedViewModel: UITableViewDelegate {
    
    /* Did select row at */
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch self.data[indexPath.section] {
        case .pictureOfTheDay(let data):
            self.delegate?.detailPageDidSelect(data: data[indexPath.row])
        }
    }
    
    //MARK: - Trailing swipe actions
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        switch self.data[indexPath.section] {
        case .pictureOfTheDay(let data):
            switch self.dataService.checkDuplicate(for: data[indexPath.row]) {
                
                /* Delete */
                
            case true:
                let deleteAction = UIContextualAction(
                    style: .destructive,
                    title: nil
                ) { (action, view, completion) in
                    self.dataService.deleteItem(for: data[indexPath.row])
                    completion(true)
                }
                deleteAction.image = UIImage(systemName: "trash")
                return UISwipeActionsConfiguration(actions: [deleteAction])
                
                /* Save */
                
            case false:
                let saveAction = UIContextualAction(
                    style: .normal,
                    title: nil
                ) { action, view, completion in
                    self.dataService.saveData(for: data[indexPath.row])
                    completion(true)
                }
                saveAction.image = UIImage(systemName: "square.and.arrow.down.on.square.fill")
                saveAction.backgroundColor = .systemBlue
                return UISwipeActionsConfiguration(actions: [saveAction])
            }
        }
    }
    
    //MARK: - Infinity scroll
    
    /* Load more data when will display the last cell */
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        switch self.data[indexPath.section] {
        case .pictureOfTheDay(let data):
            guard indexPath.row == data.count - 1 else { return }
            self.delegate?.loadMoreDidBottomScroll()
        }
    }
}
