//
//  DetailPageViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 04.08.2022.
//

import UIKit
import Kingfisher

protocol DetailPageDisplayLogic: AnyObject {
    func display(data: PlanetaryModel)
}

final class DetailPageViewController: UITableViewController {
    
    private(set) var router: (DetailPageRouterLogic & DetailPageStorePass)?
    
    private var interactor: (DetailPageInteractorLogic & DetailPageData)?
    
    private func setup() {
        let viewController = self
        let interactor = DetailPageInteractor()
        let presenter = DetailPagePresenter()
        let router = DetailPageRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.store = interactor
        viewController.interactor = interactor
        viewController.router = router
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var tableViewSections = [DetailPageSection]()
    
    private var isScrollViewTop: Bool = true
    
    //MARK: - HeaderView
    
    private lazy var headerView: ParallaxHeaderView = {
        let headerView = ParallaxHeaderView(frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height:  UIScreen.main.bounds.width + 128
        ))
        return headerView
    }()
    
    //MARK: - Bar BackButton
    
    private lazy var backButtonView: UIBarButtonItem = {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = AppConstants.UI.materialButton
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    //MARK: - Bar OptionButton
    
    private lazy var optionButtonView: UIBarButtonItem = {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = AppConstants.UI.materialButton
        button.setImage(UIImage(systemName: "textformat.size"), for: .normal)
        button.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    //MARK: - Bar AddButton
    
    private lazy var addButtonView: UIBarButtonItem = {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = AppConstants.UI.materialButton
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
}

//MARK: - Lifecycle

extension DetailPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureTableView()
        self.interactor?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIView.animate(withDuration: 0.3) {
//            if self.isScrollViewTop {
//                UIApplication.shared.statusBarUIView?.backgroundColor = .clear
//                self.navigationController?.navigationBar.backgroundColor = .clear
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIView.animate(withDuration: 0.3) {
//            if !self.isScrollViewTop {
//                UIApplication.shared.statusBarUIView?.backgroundColor = .systemBackground
//                self.navigationController?.navigationBar.backgroundColor = .systemBackground
//            }
//        }
    }
}

//MARK: - TableView DataSource

extension DetailPageViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch self.tableViewSections[section] {
        case .overview(let data):
            return data.count
        case .pagefeed(_, let data):
            return data.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewSections.count
    }
    
    //MARK: - Cell for row at
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch self.tableViewSections[indexPath.section] {
            
            /* Static overview */
            
        case .overview(let data):
            return data[indexPath.row].createdCell()
            
            /* Page feed */
            
        case .pagefeed(_, let data):
            let cell = self.tableView.dequeueReusableCell(
                withIdentifier: PlanetaryFeedTableViewCell.id,
                for: indexPath
            ) as! PlanetaryFeedTableViewCell
            cell.configure(with: data[indexPath.row])
            cell.backgroundColor = .systemBackground
            return cell
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch self.tableViewSections[indexPath.section] {
        case .overview:
            tableView.deselectRow(at: indexPath, animated: true)
        case .pagefeed(_, let data): break 
//            let destination = DetailPageViewController(coder: <#NSCoder#>)
//            destination.configure(with: data[indexPath.row], pagefeed: data)
//            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        super.tableView(tableView, heightForHeaderInSection: section)
        switch self.tableViewSections[section] {
        case .overview: return .zero
        case .pagefeed: return AppConstants.UI.headerHeight
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        switch self.tableViewSections[section] {
        case .overview:
            return nil
        case .pagefeed(header: let header, _):
            let headerView = FeedHeaderView()
            headerView.configure(title: header)
            return headerView
        }
    }
}

//MARK: - ScrollViewDelegate

extension DetailPageViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = self.tableView.tableHeaderView as? ParallaxHeaderView else { return }
        header.scrollViewDidScroll(scrollView: scrollView)
        
        if scrollView.contentOffset.y >= self.headerHeight - self.topbarHeight - 64 {
//            UIView.animate(withDuration: 0.45) {
//                self.navigationItem.title = "Overview"
//                self.isScrollViewTop = false
//                UIApplication.shared.statusBarUIView?.backgroundColor = .systemBackground
//                self.navigationController?.navigationBar.backgroundColor = .systemBackground
//            }
        } else {
//            UIView.animate(withDuration: 0.45) {
//                self.navigationItem.title = nil
//                self.isScrollViewTop = true
//                UIApplication.shared.statusBarUIView?.backgroundColor = .clear
//                self.navigationController?.navigationBar.backgroundColor = .clear
//            }
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (headerHeight - 216) && scrollView.contentOffset.y <= (headerHeight - 54)) {
            scrollView.setContentOffset(CGPoint(x: 0, y: self.headerHeight - self.topbarHeight), animated: true)
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            if (scrollView.contentOffset.y >= (headerHeight - 216) && scrollView.contentOffset.y <= (headerHeight - 54)) {
                scrollView.setContentOffset(CGPoint(x: 0, y: self.headerHeight - self.topbarHeight), animated: true)
            }
        }
    }
    
    private var headerHeight: CGFloat {
        guard
            let height = self.tableView.tableHeaderView?.bounds.height
        else { return 0 }
        return height
    }
}

//MARK: - NavigationBarButtons action

extension DetailPageViewController {
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
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
//    func configure(
//        with data: PlanetaryModel
//    ) {
//        self.headerView.titleLabelView.text = data.title
//
//        self.tableViewSections.append(.overview([
//
//            /* DetailPageBar */
//
//            DetailPageItem {
//                let cell = DetailPageBarTableViewCell()
//                cell.selectionStyle = .none
//                cell.configure(with: data.info)
//                return cell
//            },
//
//            /* DetailPageExplanation */
//
//            DetailPageItem {
//                let cell = SummaryTableViewCell()
//                cell.selectionStyle = .none
//                cell.configure(with: data.explanation)
//                return cell
//            },
//        ]))
//
////        self.tableViewSections.append(.pagefeed(header: "Might be interesting", pagefeed))
//
//        /* Header view image */
//
//        if let url = data.imageURL {
//            let resource = ImageResource(downloadURL: url)
//            self.headerView.imageView.kf
//                .setImage(
//                    with: resource,
//                    options: [
//                        .fromMemoryCacheOrRefresh,
//                        .transition(.fade(AppConstants.Core.standartDuration))
//                    ]
//                ) { result in
//                    switch result {
//                    case .success(let value):
//                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                    case .failure(let error):
//                        print("Job failed: \(error.localizedDescription)")
//                    }
//                }
//        }
//    }
    
    //MARK: - Configure Bar
    
    private func configureNavigationBar() {
        self.navigationItem.setLeftBarButton(self.backButtonView, animated: true)
        self.navigationItem.setRightBarButtonItems([self.addButtonView, self.optionButtonView], animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    
    //MARK: - Configure TableView
    
    private func configureTableView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = .systemBackground
        self.tableView.tableHeaderView = self.headerView
        self.tableView.separatorStyle = .none
        self.tableView.register(PlanetaryFeedTableViewCell.self, forCellReuseIdentifier: PlanetaryFeedTableViewCell.id)
    }
}

//MARK: - Display

extension DetailPageViewController: DetailPageDisplayLogic {
    func display(data: PlanetaryModel) {
        self.headerView.titleLabelView.text = data.title
        
        self.tableViewSections.append(.overview([
            
            /* DetailPageBar */
            
            DetailPageItem {
                let cell = DetailPageBarTableViewCell()
                cell.selectionStyle = .none
                cell.configure(with: data.info)
                return cell
            },
            
            /* DetailPageExplanation */
            
            DetailPageItem {
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
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    
}
