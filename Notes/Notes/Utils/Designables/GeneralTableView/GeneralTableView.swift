//  Skaik_mo
//
//  GeneralTableView.swift
//  Notes
//
//  Created by Mohammed Skaik on 07/12/2022.
//

import UIKit
import EmptyDataSet_Swift

class GeneralTableView: UITableView {

    var objects: [Any] = []
    var footerView: UIView?
    var footerViewHeight: CGFloat = 0.0
    var cellHeight: CGFloat = UITableView.automaticDimension
    var cellProperty: ((_ tableView: UITableView, _ indexPath: IndexPath) -> (cell: UITableViewCell, height: CGFloat))?
    var cell: UITableViewCell.Type = UITableViewCell.self {
        didSet {
            self._registerCell = cell.self
        }
    }

    // Empty Data
    private var isShowEmptyData = true//false
    var emptyImage: UIImage?
    var verticalOffset: CGFloat = 0
    var titleEmpty = ""
    var subTitleEmpty = ""

    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }

}

extension GeneralTableView {

    func resetTableView(objects: [Any], isShowLoader: Bool = true) {
        self.isShowEmptyData = false
        self.objects.removeAll()
        self.setData(objects)
    }

    private func setData(_ objects: [Any]) {
        self.objects = objects
        self.reloadData()
        self.isShowEmptyData = true
        self.reloadEmptyDataSet()
    }

    func deleteItem(index: Int) {
        let indexPath = IndexPath.init(row: index, section: 0)
        self.objects.remove(at: index)
        self.deleteRows(at: [indexPath], with: .automatic)
        if self.objects.isEmpty {
            self.reloadData()
        }
    }

}

extension GeneralTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellProperty = self.cellProperty?(tableView, indexPath) {
            self.cellHeight = cellProperty.height
            return cellProperty.cell
        }
        let cell: GeneralTableViewCell = tableView._dequeueReusableCell(withIdentifier: cell._id)
        cell.index = indexPath.item
        cell.object = self.objects[indexPath.item]
        cell.configerCell()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell {
            cell.didselect(tableView, didSelectRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.footerViewHeight
    }

}


extension GeneralTableView: EmptyDataSetSource, EmptyDataSetDelegate {

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return isShowEmptyData
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return self.emptyImage
    }

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString.init(string: self.titleEmpty, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19, weight: .bold)])
    }

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString.init(string: self.subTitleEmpty, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)])
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }

}
