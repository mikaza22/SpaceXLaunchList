//
//  LaunchListPresenter.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 07/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import Foundation

protocol LaunchListViewPresenter {
    init(view: LaunchListViewDelegate, launchDataService: APICLient)
    func getLaunchData()
}

class LaunchListPresenter: LaunchListViewPresenter {
    
    unowned let launchListView: LaunchListViewDelegate
    let launchDataService: APICLient
    
    var launchData = [LaunchData]()
    
    required init(view: LaunchListViewDelegate, launchDataService: APICLient) {
        self.launchListView = view
        self.launchDataService = launchDataService
        self.launchDataService.delegate = self
    }
    
    /**
     * Get data from APICLient
     */
    func getLaunchData() {
        launchDataService.getLaunchData()
    }
    
    /**
     * Sort by year
     */
    func sortByYear() {
        self.launchData = self.launchData.sorted { (data1, data2) -> Bool in
            return (Int(data1.launchYear ?? "0") ?? 0) > (Int(data2.launchYear ?? "0") ?? 0)
        }
    }
    
    /**
     * Set data to the view
     */
    func setLaunchData() {
        self.launchListView.setLaunchData()
    }
}

// MARK: - LaunchDataServiceDelegate
extension LaunchListPresenter: LaunchDataServiceDelegate {
    
    func onRequestError(_ error: String) {
        self.launchListView.showError(title: "Error", message: error)
    }
    
    func didReceiveLaunchData(_ launchData: [LaunchData]) {
        self.launchData = launchData
        self.sortByYear()
        self.setLaunchData()
    }
}

