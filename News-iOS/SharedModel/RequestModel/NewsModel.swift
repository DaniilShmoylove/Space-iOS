//
//  NewsModel.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import Foundation

struct NewsModel {
    init(
        id: String,
        title: String,
        image: Data?
    ) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    init(
        entity: NewsEntity
    ) {
        self.id = entity.id ?? ""
        self.title = entity.title ?? ""
        self.image = entity.image
    }
    
    let id: String
    let title: String
    let image: Data?
}
