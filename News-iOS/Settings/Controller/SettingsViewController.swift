//
//  SettingsViewController.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - TableView
    
    private var tableView = UITableView()
    
    //MARK: - Configure tableView
    
    private func configureTableView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.backgroundColor = .systemGray6
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
