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
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Constants
    private let segueListToDetail = "listToDetail"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = viewModel.title
        viewModel.getList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    // MARK: Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let target = segue.destination as? DetailViewController,
        let id = sender as? Int else { return }
        
        target.viewModel = viewModel.getDetailViewModel(with: id)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = viewModel.list.value.taskIdList else { return 0 }
        print(list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let list = viewModel.list.value.taskIdList,
            let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.setup(list[indexPath.row])
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueListToDetail, sender: indexPath.row)
    }
}
