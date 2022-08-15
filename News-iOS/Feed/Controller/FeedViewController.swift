//
//  ViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 28.07.2022.
//

import UIKit
import Alamofire

protocol FeedViewControllerLogic: AnyObject {
    func display(data: [FeedCellModel])
}

class FeedViewController: UIViewController {
    
    //MARK: - Interactor
    
    private var interactor: FeedInteractorLogic?
    
    //MARK: - Navigation Router
    
    private(set) var router: FeedRouterLogic?
    
    //MARK: - Display data
    
    private var data = [FeedCellModel]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    //MARK: - Reachability manager
    
    private var reachabilityManager: NetworkReachabilityManager?
    
    //MARK: - TableView
    
    private var tableView = UITableView() 
    
    //MARK: - Tag picker view
    
    private lazy var tagPickerView: UIBarButtonItem = {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = AppConstants.UI.materialButton
        button.setImage(UIImage(systemName: "slider.vertical.3"), for: .normal)
        button.addTarget(self, action: #selector(self.showSettingsView), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var refreshView: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        return refresh
    }()
}

//MARK: - ViewController Lifecycle

extension FeedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureNavigationBar()
        self.listenToReachability()
    }
}

//MARK: - Actions

extension FeedViewController {
    
    //MARK: - Show settings view
    
    @objc private func showSettingsView() {
        let settingsView = UINavigationController(rootViewController: SettingsViewController())
        guard let sheetSettingsView = settingsView.sheetPresentationController else { return }
        sheetSettingsView.detents = [.medium(), .large()]
        sheetSettingsView.prefersGrabberVisible = true
        sheetSettingsView.preferredCornerRadius = AppConstants.UI.cornerRadius
//        self.feedClient.saveNews { self.tableView.reloadData() }
        self.present(settingsView, animated: true)
    }
    
    //MARK: - Show more data view
    
    @objc private func showMoreDataView() {
        let settingsView = UINavigationController(rootViewController: SettingsViewController())
        guard let sheetSettingsView = settingsView.sheetPresentationController else { return }
        sheetSettingsView.prefersGrabberVisible = true
        sheetSettingsView.preferredCornerRadius = AppConstants.UI.cornerRadius
        self.present(settingsView, animated: true)
    }
    
    //MARK: - Handle refresh
    
    @objc private func handleRefresh() {
//        self.feedClient.deleteAll()
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.refreshView.endRefreshing()
        }
    }
}

//MARK: - UITableView data source & delegate

extension FeedViewController: UITableViewDataSource {
    
    //MARK: - Number of sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    //MARK: - Number of rows in section
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch self.data[section] {
        case .pictureOfTheDay(let data): return data.count
        case .explore(let data): return data.count
        case .news(let data): return data.count
        }
    }
    
    //MARK: - Cell for row at
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch self.data[indexPath.section] {
            
            //MARK: Picture of the day cell
            
        case .pictureOfTheDay(let data):
            let cell = self.tableView.dequeueReusableCell(
                withIdentifier: PlanetaryFeedTableViewCell.id,
                for: indexPath
            ) as! PlanetaryFeedTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .systemGray6
            cell.delegate = self
            cell.configure(with: data[indexPath.row])
            return cell
            
            
            //MARK: - Explore cell
            
        case .explore(let data):
            let cell = self.tableView.dequeueReusableCell(
                withIdentifier: ExploreTableViewCell.id,
                for: indexPath
            ) as! ExploreTableViewCell
            cell.configure(with: data)
            return cell
            
            //MARK: - News cell
            
        case .news:
            let _ = self.tableView.dequeueReusableCell(
                withIdentifier: PlanetaryFeedTableViewCell.id,
                for: indexPath
            ) as! PlanetaryFeedTableViewCell
//            cell.configure(with: self.feedClient.planetaryData)
            return UITableViewCell()
        }
    }
    
    //MARK: - Height for header in section
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return AppConstants.UI.headerHeight
    }
    
    //MARK: - View for header in section
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = FeedHeaderView()
        switch self.data[section] {
        case .pictureOfTheDay:
            headerView.configure(title: "Picture Of The Day", topPadding: 16)
        case .explore:
            headerView.headerAction.addTarget(self, action: #selector(self.showMoreDataView), for: .touchUpInside)
            headerView.configure(title: "Explore", isShowingHeaderAction: true)
        case .news:
            headerView.configure(title: "Hottest News")
        }
        return headerView
    }
    
    //MARK: - Did select row at
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch self.data[indexPath.section] {
        case .pictureOfTheDay(let data):
            self.router?.navigationToDetailPage(data: data[indexPath.row])
        case .explore: break
        case .news: break
        }
    }
    
    //MARK: - Configuration table view
    
    private func configureTableView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
//        self.tableView.backgroundColor = UIColor(named: "listBackground")
        self.tableView.backgroundColor = .systemGray6
        self.tableView.register(PictureDayTableViewCell.self, forCellReuseIdentifier: PictureDayTableViewCell.id)
        self.tableView.register(
            PlanetaryFeedTableViewCell.self,
            forCellReuseIdentifier: PlanetaryFeedTableViewCell.id
        )
        self.tableView.register(
            ExploreTableViewCell.self,
            forCellReuseIdentifier: ExploreTableViewCell.id
        )
        self.tableView.addSubview(refreshView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
    }
    
    private func configureNavigationBar() {
//        self.tableView.sectionHeaderTopPadding = 8
//        self.navigationController?.setNavigationItemBackground(hidden: true)
        self.navigationItem.leftBarButtonItem = self.tagPickerView
//        UIApplication.shared.statusBarUIView?.backgroundColor = .systemBackground
//        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
}

extension FeedViewController: PlanetaryFeedTableViewCellDelegate {
    func didAddButtonTap(index: Int) {
        print(index)
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            completion(true)
        }
        saveAction.image = UIImage(systemName: "square.and.arrow.down.on.square.fill")
        saveAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [saveAction])
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
                
                guard self.data.count == 0 else { return }
                self.navigationItem.prompt = nil
                self.interactor?.fetchData()
                
                /* Not reachanle */
                
            case .notReachable:
                
                self.navigationItem.prompt = "Connection error"
                
                /* Unknown */
                
            case .unknown: break
            }
        }
    }
}

//MARK: - Display

extension FeedViewController: FeedViewControllerLogic {
    func display(data: [FeedCellModel]) {
        self.data = data
        self.tableView.reloadData()
    }
}
