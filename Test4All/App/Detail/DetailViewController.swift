//
//  DetailViewController.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

class DetailViewController: UpdatableViewController {
    
    // MARK: - Outlets
    
    // MARK: - Constants
    var viewModel: DetailViewModel?
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        
        self.title = viewModel.title
        self.bind(with: viewModel.networkingState)
        
//        viewModel.list.bind { _, _ in
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        
        viewModel.getTask()
    }
    
    
    // MARK: - Actions
    
    // MARK: - Functions
    
}
