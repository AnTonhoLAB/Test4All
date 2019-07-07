//
//  Task.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

struct Task: Codable {
    var id: String?
    var city: String?
    var neighboorhood: String?
    var urlPhoto: String?
    var urlLogo: String?
    var title: String?
    var telephoneNumber: String?
    var descriptionText: String?
    var address: String?
    var latitude: Double?
    var longitude: Double?
}
