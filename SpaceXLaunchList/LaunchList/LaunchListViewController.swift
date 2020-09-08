//
//  ViewController.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 06/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import UIKit
import WebKit

class LaunchListViewController: UIViewController {
    
    // MARK: - variables
    // The presenter responsible for the logic of LaunchListViewController
    var presenter: LaunchListPresenter?
    
    var reuseIdentifier = "launchDataCell"
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.webView.navigationDelegate = self
        presenter = LaunchListPresenter(view: self, launchDataService: APICLient())
        presenter?.getLaunchData()
    }
    
    /**
     * Play video
     - Parameter sender: the selected row Button
     */
    @objc func playVideo(sender: UIButton) {
        self.addSpinner(onView: self.view)
        if let videoLink = self.presenter?.launchData[sender.tag].links?.videoLink, let videoURL = URL(string: videoLink) {
            webView.load(URLRequest(url: videoURL))
        } else {
            self.showError(title: "Error", message: "No video found")
            self.removeSpinner()
        }
    }
}

// MARK: - LaunchDataViewDelegate
extension LaunchListViewController: LaunchListViewDelegate {
    
    func setLaunchData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title: title, message: message)
        }
    }
    
}

// MARK: - WKNavigationDelegate
extension LaunchListViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.removeSpinner()
    }
    
}

// MARK: - UITableViewDataSource
extension LaunchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.launchData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LaunchListTableViewCell {
            cell.missionName.text = self.presenter?.launchData[indexPath.row].missionName
            cell.launchYear.text = self.presenter?.launchData[indexPath.row].launchYear
            if let imageLink = self.presenter?.launchData[indexPath.row].links?.missionPatchSmall, let imageURL = URL(string: imageLink) {
                cell.launchImage.load(url: imageURL, placeholder: "rocket")
            }
            if self.presenter?.launchData[indexPath.row].links?.videoLink == nil {
                cell.playVideoButton.isHidden = true
            } else {
                cell.playVideoButton.isHidden = false
                cell.playVideoButton.tag = indexPath.row
                cell.playVideoButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}


