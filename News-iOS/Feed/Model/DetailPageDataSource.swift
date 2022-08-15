////
////  DetailPageDataSource.swift
////  News-iOS
////
////  Created by Daniil Shmoylove on 10.08.2022.
////
//
//import UIKit
//
//final class DetailPageDataSource: NSObject {
//    
//    private var tableViewSections = [DetailPageItem]()
//    
//    override init() {
//        super.init()
//        self.configureDataSource()
//    }
//
//    private func configureDataSource() {
//        let getInTouchSection: [DetailPageItem] = [
//            DetailPageItem(createdCell: {
//                let cell = DetailPageBarTableViewCell()
//                cell.selectionStyle = .none
//                return cell
//
//            }),
//            
//            DetailPageItem(
//                createdCell: {
//                    let cell = SummaryTableViewCell(style: .default, reuseIdentifier: SummaryTableViewCell.id)
//                    cell.selectionStyle = .none
//                    cell.configure(for: String(repeating: "IIFL Finance on Thursdaxay said it has raised its stake in subsidiary company IIFL Samasta Finance by acquiring over 12.4 crore shares from wholly-owned arm IIFL Home Finance for Rs 259 crore. With this additional holding representing 25 per cent of equity share capital, the stake of IIFL Finance has increased to 99.41 per cent from 74.41 per cent earlier in IIFL Samasta. The said transaction was completed on July 27, 2022, and accordingly, the company's shareholding in IIFL Samasta increased from 74.", count: .random(in: 1...8)))
//
//                    return cell
//                }
//            )
//        ]
//        self.tableViewSections = getInTouchSection
//    }
//}
//
////MARK: - Detail page item
//
//fileprivate struct DetailPageItem {
//    var createdCell: () -> UITableViewCell
//}
//
////MARK: - UITableViewDelegate & UITableViewDataSource
//
//extension DetailPageDataSource: UITableViewDelegate, UITableViewDataSource {
//    func tableView(
//        _ tableView: UITableView,
//        numberOfRowsInSection section: Int
//    ) -> Int {
//        return self.tableViewSections.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableViewSections[indexPath.row]
//        return cell.createdCell()
//    }
//    
//    func tableView(
//        _ tableView: UITableView,
//        didSelectRowAt indexPath: IndexPath
//    ) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
