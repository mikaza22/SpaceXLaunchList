//
//  UIViewControllerExtension.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 08/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import UIKit

var globalSpinnerView : UIView?

extension UIViewController {
    
    func addSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        globalSpinnerView = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            globalSpinnerView?.removeFromSuperview()
            globalSpinnerView = nil
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
