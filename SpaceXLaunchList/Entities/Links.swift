//
//  Links.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 07/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import Foundation

struct Links : Decodable {
    let videoLink : String?
    let missionPatchSmall : String?
    
    enum CodingKeys: String, CodingKey {
        
        case videoLink = "videoLink"
        case missionPatchSmall = "missionPatchSmall"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoLink = try values.decodeIfPresent(String.self, forKey: .videoLink)
        missionPatchSmall = try values.decodeIfPresent(String.self, forKey: .missionPatchSmall)
    }
    
    init(videoLink: String, imageLink: String) {
        self.videoLink = videoLink
        self.missionPatchSmall = imageLink
    }
    
}
