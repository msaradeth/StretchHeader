//
//  ListVC.swift
//  StretchHeader
//
//  Created by Mike Saradeth on 5/9/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    //set up views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        return tableView
    }()
    var stretchHeader: StretchHeader
    var items: [String]
    
    
    init(items: [String?], stretchHeader: StretchHeader) {
        self.items = items.compactMap{ $0 }.sorted(by: { $0 < $1 })
        self.stretchHeader = stretchHeader
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init?(coder aDecoder: NSCoder) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupTableView()
    }

    
    private func setupHeaderView() {
        view.addSubview(stretchHeader)
        stretchHeader.anchorToSuperView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.topAnchor.constraint(equalTo: stretchHeader.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}

extension ListVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 150))
//        imageView.image = UIImage(named: "header")
//        imageView.clipsToBounds = true
//        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
//        view.backgroundColor = .yellow
//        return view
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        title = items[indexPath.row]
    }
}

extension ListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        stretchHeader.stretch(contentOffset: scrollView.contentOffset)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        stretchHeader.setToDefaultHeight()
    }
}
