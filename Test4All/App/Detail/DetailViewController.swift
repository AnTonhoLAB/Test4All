//
//  DetailViewController.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

class DetailViewController: UpdatableViewController {
    
    enum Segues: String {
        case toServices
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var backGroundImage: UIImageView!
    @IBOutlet private weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
            avatarImage.clipsToBounds = true
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionText: UILabel!
    
    // MARK: - Constants
    var viewModel: DetailViewModel?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = viewModel else { return }
        
        self.title = viewModel.title
        self.bind(with: viewModel.networkingState)
        
        backGroundImage.bind(with: viewModel.photo)
        avatarImage.bind(with: viewModel.logo)
        
        descriptionText.bind(with: viewModel.description)
        titleLabel.bind(with: viewModel.taskTitle)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        
        viewModel.getTask()
    }
    
    // MARK: - Actions
    @IBAction func didTaPhone(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        let number = viewModel.phone.value
        alertMessage("Ligar para: \(number)?", action: { _ in
            UIApplication.shared.open(URL(string: "tel://\(number)")!)
        }, with: true)
        
    }
    
    @IBAction func didTapServices(_ sender: Any) {
        performSegue(withIdentifier: Segues.toServices.rawValue, sender: nil)
    }
    
    @IBAction func didTapAddress(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        self.alertMessage(viewModel.address.value, action: nil)
    }
    
    @IBAction func didTapComments(_ sender: Any) {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
        if(bottomOffset.y > 0) {
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    @IBAction func didTapFavorites(_ sender: Any) {
        
    }
    // MARK: - Functions
    
}

extension UILabel : Bindable {
    public typealias BindingType = String
    
    public func observingValue() -> String {
        return self.text ?? ""
    }
    
    public func updateValue(with value: String) {
        self.text = value
    }
}

extension UIImageView : Bindable {
    public typealias BindingType = Data
    
    public func observingValue() -> Data {
        return (self.image?.pngData()!)!
    }
    
    public func updateValue(with value: Data) {
        self.image = UIImage(data: value)
    }
}
