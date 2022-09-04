//
//  SavedDataViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import UIKit

protocol SavedDataDisplayLogic: AnyObject {
    func display(data: [FeedCellModel])
}

final class SavedDataViewController: UITableViewController {
    
    //MARK: - Interactor
    
    private var interactor: SavedDataInteractor?
    
    //MARK: - Navigation Router
    
    private(set) var router: FeedRouterLogic?
    
    //MARK: - ViewModel
    
    private var viewModel: SavedDataViewModel!
    
    //MARK: - Init
    
    init() { super.init(nibName: nil, bundle: nil); self.setup() }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup
    
    private func setup() {
        let viewController = self
        let presenter = SavedDataPresenter()
        let interactor = SavedDataInteractor()
        let router = FeedRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SavedDataViewModel(delegate: self)
        self.configureSavedData()
    }
    
    //MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await self.interactor?.fetchData() }
    }
    
    //MARK: - Configure saved data
    
    private func configureSavedData() {
        self.navigationItem.searchController = self.viewModel.searchController
        self.definesPresentationContext = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.register(
            PlanetaryDefaultTableViewCell.self,
            forCellReuseIdentifier: PlanetaryDefaultTableViewCell.id
        )
        self.tableView.backgroundColor = .systemGray6
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
    }
}

//MARK: - SavedDataViewModelDelegate

extension SavedDataViewController: SavedDataViewModelDelegate {
    func savedItemDidSelect(data: PlanetaryModel) {
        self.router?.routeToDetailPage(data: data)
    }
    
    func searchResultsDidUpdate() {
        self.tableView.reloadData()
    }
    
    func deleteItemDidSwipe(at indexPath: IndexPath) {
        Task { await self.interactor?.fetchData() }
    }
}

//MARK: - Display

extension SavedDataViewController: SavedDataDisplayLogic {
    func display(data: [FeedCellModel]) {
        self.viewModel.data = data
        self.tableView.reloadData()
    }
}
