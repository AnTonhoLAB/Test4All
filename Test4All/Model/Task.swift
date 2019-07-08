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

    public enum CodingKeys: String, CodingKey {
        case id 
        case city = "cidade"
        case neighboorhood = "bairro"
        case urlPhoto = "urlFoto"
        case urlLogo
        case title = "titulo"
        case telephoneNumber = "telefone"
        case descriptionText = "texto"
        case address = "endereco"
        case latitude
        case longitude
    }

//    "id":"1",
//    "cidade":"Porto Alegre",
//    "bairro":"Moinhos de Vento",
//    "urlFoto":"http://dev.4all.com:3003/foto_01.jpg",
//    "urlLogo":"http://dev.4all.com:3003/logo_01.png",
//    "titulo":"Lorem Ipsum",
//    "telefone":"5122333311",
//    "texto":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus finibus consequat nulla, a laoreet ipsum blandit ac. Donec vitae convallis nisi. Mauris molestie id lorem quis dignissim. Cum sociis natoque penatibus et magnis dis parturient montes.",
//    "endereco":"Avenida Carlos Gomes, 532",
//    "latitude":-30.0306551,
//    "longitude":-51.1846846,
}
