//
//  PuppyModel.swift
//  RocketDataDemo
//
//  Created by Kevin Smith on 7/7/17.
//  Copyright © 2017 Kevin Smith. All rights reserved.
//

import Foundation
import RocketData

struct PuppyService: Decodable {
    let posts: [PuppyModel]
}

struct PuppyModel: Codable, Equatable {
    var id: String
    var caption: String?
    var imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case caption = "photo-caption"
        case imageURL = "photo-url-1280"
    }
}

extension PuppyModel: SampleAppModel {
    
    init?(data: [AnyHashable: Any]) {
        guard let id = data["id"] as? String,
            let caption = data["caption"] as? String,
            let imageURL = data["imageURL"] as? String else {
                return nil
        }
        self.id = id
        self.caption = caption
        self.imageURL = imageURL
    }
    
    func data() -> [AnyHashable: Any] {
        return [
            "id": id,
            "caption": caption ?? "",
            "imageURL": imageURL ?? ""
        ]
    }
}
    
extension PuppyModel: Model {
    var modelIdentifier: String? {
        // ensure this is globally unique
        return "Puppy:\(id)"
    }
    
    func map(_ transform: (Model) -> Model?) -> PuppyModel? {
        // No child objects, so we can just return self
        return self
    }
    
    func forEach(_ visit: (Model) -> Void) {
    }
}

func ==(lhs: PuppyModel, rhs: PuppyModel) -> Bool {
    return lhs.id == rhs.id &&
        lhs.caption == rhs.caption &&
        lhs.imageURL == rhs.imageURL
}
