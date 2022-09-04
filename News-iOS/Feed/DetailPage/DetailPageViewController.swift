//
//  DetailPageViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 04.08.2022.
//

import UIKit
import Kingfisher
import Alamofire

//MARK: - DetailPageViewController protocol

protocol DetailPageDisplayLogic: AnyObject {
    func display(data: PlanetaryModel)
    func displayFeed(data: [PlanetaryModel])
}

//MARK: - DetailPageViewController class

final class DetailPageViewController: UITableViewController {
    
    //MARK: - Interactor
    
    private var interactor: (DetailPageInteractorLogic & DetailPageData)?
    
    //MARK: - Navigation Router
    
    private(set) var router: (DetailPageRouterLogic & DetailPageDataPassing)?
    
    //MARK: - Reachability manager
    
    private var reachabilityManager = NetworkReachabilityManager()
    
    //MARK: - DataSource
    
    private var dataSource = DetailPageDataSource()
    
    //MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailPageInteractor()
        let presenter = DetailPagePresenter()
        let router = DetailPageRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
    
    //MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HeaderView
    
    private lazy var headerView = ParallaxHeaderView()
    
    //MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureTableView()
        self.interactor?.fetchData()
        self.interactor?.fetchFeedData()
        self.listenToReachability()
    }
}

//MARK: - UITableView delgate

extension DetailPageViewController {
    
    /* Did select row at */
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch self.dataSource.tableViewSections[indexPath.section] {
        case .overview: break
        case .pagefeed(let data):
            self.router?.routeToDetaiPage(data: data[indexPath.row])
        }
    }
    
    /* Will display cell */
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        switch self.dataSource.tableViewSections[indexPath.section] {
        case .overview(let data):
            guard
                indexPath.row == data.count - 1,
                self.dataSource.tableViewSections.count == 1
            else { return }
            self.interactor?.fetchFeedData()
        case .pagefeed: break
        }
    }
    
    /* Scroll view did scroll */
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = self.tableView.tableHeaderView as? ParallaxHeaderView else { return }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
    
    /* Scroll view did end decelerating */
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (headerHeight - 216) && scrollView.contentOffset.y <= (headerHeight - 54)) {
            scrollView.setContentOffset(CGPoint(x: 0, y: self.headerHeight - self.topbarHeight), animated: true)
        }
    }
    
    /* Scroll view did end dragging */
    
    override func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        if !decelerate {
            if (scrollView.contentOffset.y >= (headerHeight - 216) && scrollView.contentOffset.y <= (headerHeight - 54)) {
                scrollView.setContentOffset(CGPoint(x: 0, y: self.headerHeight - self.topbarHeight), animated: true)
            }
        }
    }
    
    /* Header height */
    
    private var headerHeight: CGFloat {
        guard
            let height = self.tableView.tableHeaderView?.bounds.height
        else { return 0 }
        return height
    }
}

//MARK: - Back swipe gesture

extension DetailPageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}

//MARK: - Configure ViewController

extension DetailPageViewController {
    
    //MARK: - Configure Bar
    
    private func configureNavigationBar() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.setLeftBarButton(
            .createBarButtonItem(
                iconString: "xmark",
                target: self,
                action: #selector(self.backAction)),
            animated: true)
        self.navigationItem.setRightBarButtonItems([
            .createBarButtonItem(iconString: "textformat.size"),
            .createBarButtonItem(iconString: "plus")
        ], animated: true)
    }
    
    //MARK: - Configure TableView
    
    private func configureTableView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = .systemBackground
        self.tableView.tableHeaderView = self.headerView
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self.dataSource
        self.tableView.register(PlanetaryDefaultTableViewCell.self, forCellReuseIdentifier: PlanetaryDefaultTableViewCell.id)
    }
    
    //MARK: - NavigationBarButtons action
    
    @objc private func backAction() { self.navigationController?.popViewController(animated: true) }
}

//MARK: - Display

extension DetailPageViewController: DetailPageDisplayLogic {
    func display(data: PlanetaryModel) {
        self.headerView.titleLabelView.text = data.title
        
        self.dataSource.tableViewSections.append(.overview([
            
            /* DetailPageBar */
            
            TableViewItem {
                let cell = DetailPageBarTableViewCell()
                cell.selectionStyle = .none
                cell.configure(with: data.copyrightWithDate)
                return cell
            },
            
            /* DetailPageExplanation */
            
            TableViewItem {
                let cell = SummaryTableViewCell()
                cell.selectionStyle = .none
                cell.configure(with: data.explanation)
                return cell
            },
        ]))
        
        /* Header view image */
        
        if let url = data.imageURL {
            let resource = ImageResource(downloadURL: url)
            self.headerView.imageView.kf
                .setImage(
                    with: resource,
                    options: [
                        .fromMemoryCacheOrRefresh,
                        .transition(.fade(AppConstants.Core.standartDuration))
                    ]
                ) { result in
                    switch result {
                    case .success(let value):
                        self.reachabilityManager?.startListening { [weak self] status in
                            guard let self = self else { return }
                            switch status {
                            case .reachable(let type):
                                
                                /* Check ethernet or WiFi type */
                                
                                guard type == .ethernetOrWiFi else { return }
                                guard let url = data.imageHDURL else { return }
                                let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
                                self.headerView.imageView.kf.setImage(
                                    with: resource,
                                    placeholder: value.image,
                                    options: [
                                        .fromMemoryCacheOrRefresh,
                                        .transition(.fade(AppConstants.Core.standartDuration))
                                    ])
                            case .notReachable: break
                            case .unknown: break
                            }
                        }
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func displayFeed(data: [PlanetaryModel]) {
        self.dataSource.tableViewSections.append(.pagefeed(data))
        self.tableView.reloadData()
    }
}

// MARK: - Network Reachability

extension DetailPageViewController {
    private func listenToReachability() {
        self.reachabilityManager?.startListening { [weak self] status in
            guard let self = self else { return }
            switch status {
                
                /* Reachable */
                
            case .reachable:
                
                /* Refresh data or fetch data */
                
                self.navigationItem.prompt = nil
                guard self.dataSource.tableViewSections.count == 1 else { return }
                self.interactor?.fetchFeedData()
                
                /* Not reachanle */
                
            case .notReachable:
                
                self.navigationItem.prompt = "Connection error"
                
                /* Unknown */
                
            case .unknown: break
            }
        }
    }
}
