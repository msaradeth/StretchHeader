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
    var items: [Contact]
    
    
    init(items: [Contact], stretchHeader: StretchHeader) {
        self.items = items  //items.compactMap{ $0 }.sorted(by: { $0 < $1 })
        self.stretchHeader = stretchHeader
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete Row", style: .plain, target: self, action: #selector(remove))
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init?(coder aDecoder: NSCoder) not implemented")
    }
    
    @objc func add() {
        items.append(Contact(firstName: String(0), lastName: String(items.count)))
        let indexPath = IndexPath(row: items.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    @objc func remove() {
        items.removeLast()
        let indexPath = IndexPath(row: items.count, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
        cell.textLabel?.text = items[indexPath.row].fullName
        
        return cell
    }
}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        title = items[indexPath.row].fullName
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
