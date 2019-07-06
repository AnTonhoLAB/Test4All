//
//  Comment.swift
//  Test4All
//
//  Created by George Gomes on 06/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import Foundation

class Comment: Codable {
    var comment: String?
    var title: String?
    var name: String?
    var grade: Int?
    var urlPicture: String?

    public enum CodingKeys: String, CodingKey {
        case comment = "comentario"
        case title = "titulo"
        case name = "nome"
        case grade = "nota"
        case urlPicture = "urlFoto"
    
    }
}
