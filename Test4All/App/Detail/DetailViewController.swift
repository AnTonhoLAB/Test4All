//
//  DetailViewController.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UpdatableViewController {
    
    enum Segues: String {
        case toServices
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var backGroundImage: UIImageView!
    @IBOutlet private weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
            avatarImage.clipsToBounds = true
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionText: UILabel!
    @IBOutlet private weak var map: MKMapView!
    @IBOutlet private weak var addressMapLabel: UILabel!
    @IBOutlet private weak var pinMapImage: UIImageView! {
        didSet {
            pinMapImage.layer.cornerRadius = pinMapImage.frame.size.width / 2
            pinMapImage.clipsToBounds = true
        }
    }
    
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
        
        map.bind(with: viewModel.location)
        addressMapLabel.bind(with: viewModel.address)
        
        viewModel.comments.bind { (_, comments) in
            self.setup(comments: comments)
        }
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
        UIApplication.shared.open(URL(string: "tel://\(number)")!)
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
    private func setup(comments: [Comment]) {
        DispatchQueue.main.async {
            for comment in comments {
                let commentView = CommentView(with: comment, provider: TaskProvider(nil))
                self.stackView.addArrangedSubview(commentView)
            }
            self.view.layoutSubviews()
        }
    }
}

extension UILabel: Bindable {
    public typealias BindingType = String
    
    public func observingValue() -> String {
        return self.text ?? ""
    }
    
    public func updateValue(with value: String) {
        self.text = value
    }
}
