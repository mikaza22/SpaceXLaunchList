//
//  LaunchListView.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 06/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

protocol LaunchListViewDelegate: class {
    func setLaunchData()
    func showError(title: String, message: String)
}
