//
//  LaunchData.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 07/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import Foundation

struct LaunchData : Decodable {
    let missionName : String?
    let launchYear : String?
    let links : Links?
 

    enum CodingKeys: String, CodingKey {

        case missionName = "missionName"
        case launchYear = "launchYear"
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        missionName = try values.decodeIfPresent(String.self, forKey: .missionName)
        launchYear = try values.decodeIfPresent(String.self, forKey: .launchYear)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }
    
    init(missionName: String, launchYear: String, links: Links) {
        self.missionName = missionName
        self.launchYear = launchYear
        self.links = links
    }

}
