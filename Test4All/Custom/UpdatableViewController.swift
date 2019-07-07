//
//  UpdatableViewController.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

// ViewController with bind to diplay loading indicator
class UpdatableViewController: UIViewController, Bindable {
    
    typealias BindingType = NetworkingState
    private var loadView : UIView?
    
    private var state: NetworkingState = .default {
        didSet {
            switch state {
            case .loading:
                self.showLoading()
            case .success:
                self.removeLoading()
            case .fail(let error):
                print(error)
                self.removeLoading()
            case .default:
                break
            }
        }
    }
    
    func updateValue(with value: NetworkingState) {
        self.state = value
    }
    
    func observingValue() -> NetworkingState {
        return state
    }
    
}

extension UpdatableViewController {
    
    func showLoading() {
        let wallView = UIView.init(frame: self.view.bounds)
        wallView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView.init(style: .whiteLarge)
        indicator.startAnimating()
        indicator.center = wallView.center
        
        DispatchQueue.main.async {
            wallView.addSubview(indicator)
            self.view.addSubview(wallView)
        }
        
        loadView = wallView
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            self.loadView?.removeFromSuperview()
            self.loadView = nil
        }
    }
}

