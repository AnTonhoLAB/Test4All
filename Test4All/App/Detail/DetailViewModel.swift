//
//  DetailViewModel.swift
//  Test4All
//
//  Created by George Gomes on 07/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    private var id: String!
    private var provider: TaskProviderProtocol!
    
    let title = ""
    let networkingState: Observable<NetworkingState> = Observable(.default)
    
    private let task = Observable<Task>(Task())
    private let photoUrl = Observable<String>("")
    private let logoUrl = Observable<String>("")
    
    let cidade = Observable<String>("")
    let city = Observable<String>("")
    let address = Observable<String>("")
    let phone = Observable<String>("")
    let description = Observable<String>("")
    let taskTitle = Observable<String>("")
    let photo = Observable<Data>(Data())
    let logo = Observable<Data>(Data())
    
    
    let comments = Observable<[Comment]>([Comment]())
    
    init(_ provider: TaskProviderProtocol, _ id: String ) {
        self.id = id
        self.provider = provider
    }
    
    func getTask() {
        networkingState.value = .loading
        provider.getTask(with: id) { result in
            switch result {
            case .success(let task):
                self.networkingState.value = .success
                self.task.value = task
                self.city.value = task.city ?? ""
                self.description.value = task.descriptionText ?? ""
                self.taskTitle.value = task.title ?? ""
                self.address.value = task.address ?? ""
                self.phone.value = task.telephoneNumber ?? ""
                self.comments.value = task.comments ?? [Comment]()
                self.photoUrl.value = task.urlPhoto ?? ""
                self.logoUrl.value = task.urlLogo ?? ""
                self.loadImages()
            case .failure(let err):
                self.networkingState.value = .fail(err)
            }
        }
    }
    
    private func loadImages() {
        provider.getImageData(withLink: self.photoUrl.value) { (result) in
            switch result {
            case .success(let bgData):
                self.photo.value = bgData
            case .failure(_):
                break
            }
        }
        provider.getImageData(withLink: self.logoUrl.value) { (result) in
            switch result {
                
            case .success(let logoData):
                self.logo.value = logoData
            case .failure(_):
                break
            }
        }
    }
}
