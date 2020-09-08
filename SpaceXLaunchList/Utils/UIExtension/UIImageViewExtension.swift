//
//  UIImageViewExtension.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 08/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL?, placeholder: String) {
        if let url = url {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: placeholder)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = UIImage(named: placeholder)
            }
        }
    }
}

