//
//  Extensions.swift
//  Stockey
//
//  Created by Vandan Patel on 12/26/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

let activityIndicator = UIActivityIndicatorView()
let container = UIView()
let loadingView = UIView()

extension UIViewController {
    func showActivityIndicator() {
        let container = containerViewForActivityIndicator()
        let loadingView = loadingViewForActivityIndiCator()
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
        loadingView.removeFromSuperview()
        activityIndicator.removeFromSuperview()
    }
    
    func containerViewForActivityIndicator() -> UIView {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        return container
    }
    
    func loadingViewForActivityIndiCator() -> UIView {
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10.0
        return loadingView
    }
}
