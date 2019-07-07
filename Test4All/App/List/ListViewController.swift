//
//  ListViewController.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

final class ListViewController: UpdatableViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Constants
    let viewModel: ListViewModel! = ListViewModel(TaskProvider())
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(with: viewModel.networkingState)
        
        viewModel.list.bind { _, _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getList()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasks = viewModel.list.value, let list = tasks.taskIdList else { return 0 }
        print(list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasks = viewModel.list.value,
            let list = tasks.taskIdList,
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.setup(list[indexPath.row])
        
        return cell
    }
}
