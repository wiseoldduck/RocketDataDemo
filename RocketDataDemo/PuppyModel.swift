//
//  PuppyModel.swift
//  RocketDataDemo
//
//  Created by Kevin Smith on 7/7/17.
//  Copyright © 2017 Kevin Smith. All rights reserved.
//

import Foundation

struct PuppyService: Decodable {
    let posts: [PuppyModel]
}

struct PuppyModel:Codable {
    var caption: String?
    var imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case caption = "photo-caption"
        case imageURL = "photo-url-1280"
    }
}

extension PuppyModel {
    
    init?(data: [AnyHashable: Any]) {
        guard let caption = data["caption"] as? String,
            let imageURL = data["imageURL"] as? String else {
                return nil
        }
        
        self.caption = caption
        self.imageURL = imageURL
    }
    
    func data() -> [AnyHashable: Any] {
        return [
            
            "caption": caption ?? "",
            "imageURL": imageURL ?? ""
        ]
    }
}
