//
//  SavedDataViewModel.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 22.08.2022.
//

import Foundation
import UIKit

final class SavedDataViewModel: NSObject {
    
    //MARK: - Display data
    
    var data = [FeedCellModel]()
    
    //MARK: - Searched data
    
    var searchedData = [FeedCellModel]()
    
    //MARK: - Data service
    
    private var dataService = DataService.shared
    
    //MARK: - Delegate
    
    private weak var delegate: SavedDataViewModelDelegate?
    
    //MARK: - SearchController
    
    private(set) var searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Init
    
    init(delegate: SavedDataViewModelDelegate) {
        super.init()
        self.delegate = delegate
        self.configureSearchController()
    }
}

//MARK: - UITableViewDataSource

extension SavedDataViewModel: UITableViewDataSource {
    
    /* Number of sections */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        (self.isSearching ? self.searchedData.count : self.data.count)
    }
    
    /* Number of rows in section */
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch (
            self.isSearching ?
            self.searchedData[section] :
                self.data[section]
        ) {
        case .pictureOfTheDay(let data): return data.count
        }
    }
    
    //MARK: - Cell for row at
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch (
            self.isSearching ?
            self.searchedData[indexPath.section] :
                self.data[indexPath.section]
        ) {
        case .pictureOfTheDay(let data):
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

//MARK: - SavedDataViewModelDelegate

protocol SavedDataViewModelDelegate: AnyObject {
    func deleteItemDidSwipe(at indexPath: IndexPath)
    func searchResultsDidUpdate()
    func savedItemDidSelect(data: PlanetaryModel)
}

//MARK: - UITableViewDelegate

extension SavedDataViewModel: UITableViewDelegate {
    
    /* Did select row at */
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch (
            self.isSearching ?
            self.searchedData[indexPath.section] :
                self.data[indexPath.section])
        {
        case .pictureOfTheDay(let data):
            self.delegate?.savedItemDidSelect(data: data[indexPath.row])
        }
    }
    
    
    /* Trailing swipe actions */
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        switch self.data[indexPath.section] {
        case .pictureOfTheDay(let data):
            switch self.dataService.checkDuplicate(for: data[indexPath.row]) {
                
                /* Delete */
                
            case true:
                let deleteAction = UIContextualAction(style: .normal, title: nil) { action, view, completion in
                    self.dataService.deleteItem(for: data[indexPath.row])
                    self.delegate?.deleteItemDidSwipe(at: indexPath)
                    completion(true)
                }
                deleteAction.image = .Icons.delete
                deleteAction.backgroundColor = .systemRed
                return UISwipeActionsConfiguration(actions: [deleteAction])
                
                /* Save */
                
            case false:
                let saveAction = UIContextualAction(style: .normal, title: nil) { action, view, completion in
                    self.dataService.saveData(for: data[indexPath.row])
                    completion(true)
                }
                saveAction.image = .Icons.add
                saveAction.backgroundColor = .systemBlue
                return UISwipeActionsConfiguration(actions: [saveAction])
            }
        }
    }
}

//MARK: - UISearchResultsUpdating

extension SavedDataViewModel: UISearchResultsUpdating {
    
    /* Update search results */
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.search(for: text)
        self.delegate?.searchResultsDidUpdate()
    }
    
    //MARK: - Search
    
    /* Search data by explanation */
    
    private func search(
        for text: String
    ) {
        self.searchedData = self.data.map {
            switch $0 {
            case .pictureOfTheDay(let data):
                return .pictureOfTheDay(
                    data.filter {
                        guard
                            let explanation = $0.explanation,
                            let title = $0.title,
                            let date = $0.date,
                            let mediaType = $0.mediaType
                        else { return false }
                        
                        let items = Mirror(reflecting: (
                            title,
                            explanation,
                            date,
                            mediaType
                        ))
                        
                        return (items.children.filter {
                            ($0.value as! String)
                                .lowercased()
                                .contains(text.lowercased())
                        })
                        .count > 0
                    }
                )
            }
        }
    }
    
    /* Search bar is searching */
    
    private var isSearching: Bool {
        guard let textIsEmpty = self.searchController.searchBar.text?.isEmpty else { return false }
        return self.searchController.isActive && !textIsEmpty
    }
    
    //MARK: - Configure searchController
    
    private func configureSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
    }
}
