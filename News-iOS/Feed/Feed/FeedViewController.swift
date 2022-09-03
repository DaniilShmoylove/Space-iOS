//
//  ViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 28.07.2022.
//

import UIKit
import Alamofire
import Resolver

//MARK: - FeedViewController protocol

protocol FeedDisplayLogic: AnyObject {
    func display(data: [FeedCellModel])
    func displayExplore(data: [FeedCellModel])
}

//MARK: - FeedViewController class 

final class FeedViewController: UITableViewController {
    
    //MARK: - Interactor
    
    private var interactor: FeedInteractorLogic?
    
    @Injected private var authenticationService: AuthenticationService
    
    //MARK: - Navigation Router
    
    private(set) var router: FeedRouterLogic?
    
    //MARK: - Reachability manager
    
    private var reachabilityManager: NetworkReachabilityManager?
    
    //MARK: - ViewModel
    
    private var viewModel: FeedViewModel!
    
    //MARK: - Init
    
    init() { super.init(nibName: nil, bundle: nil); self.setup() }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup
    
    private func setup() {
        let viewController = self
        let presenter = FeedPresenter()
        let interactor = FeedInteractor()
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
        self.viewModel = FeedViewModel(delegate: self)
        self.configureTableView()
        self.listenToReachability()
    }
}

// MARK: - Network Reachability

extension FeedViewController {
    private func listenToReachability() {
        self.reachabilityManager = NetworkReachabilityManager()
        self.reachabilityManager?.startListening { [weak self] status in
            guard let self = self else { return }
            switch status {
                
                /* Reachable */
                
            case .reachable:
                
                /* Refresh data or fetch data */
                
                self.navigationItem.prompt = nil
                guard self.viewModel.data.count == 0 else { return }
                Task { try await self.interactor?.fetchData() } 
                
                /* Not reachanle */
                
            case .notReachable:
                
                self.navigationItem.prompt = "Connection error"
                
                /* Unknown */
                
            case .unknown: break
            }
        }
    }
}

//MARK: - Configure FeedViewController

extension FeedViewController {
    
    /* Configure table view */
    
    private func configureTableView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = .systemGray6
        self.tableView.register(PlanetaryLargeTableViewCell.self, forCellReuseIdentifier: PlanetaryLargeTableViewCell.id)
        self.tableView.register(PlanetaryDefaultTableViewCell.self, forCellReuseIdentifier: PlanetaryDefaultTableViewCell.id)
        self.tableView.dataSource = self.viewModel
        self.tableView.delegate = self.viewModel
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.isEnabled = true
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
    }
}

//MARK: - Handle refresh

extension FeedViewController {
    @objc private func handleRefresh() {
        Task {
            do {
                try await self.interactor?.fetchData()
                self.refreshControl?.endRefreshing()
            } catch {
                print(error.localizedDescription)
                self.refreshControl?.endRefreshing()
            }
        }
    }
}


//MARK: - FeedViewModelDelegate

extension FeedViewController: FeedViewModelDelegate {
    func detailPageDidSelect(data: PlanetaryModel) {
        self.router?.routeToDetailPage(data: data)
    }
    
    func loadMoreDidBottomScroll() {
        self.interactor?.loadMore()
    }
}

//MARK: - Display

extension FeedViewController: FeedDisplayLogic {
    func display(data: [FeedCellModel]) {
        self.viewModel.data = data
        self.tableView.reloadData()
    }
    
    func displayExplore(data: [FeedCellModel]) {
        self.viewModel.data = data
        self.tableView.reloadSections(IndexSet(integer: .zero), with: .fade)
    }
}
