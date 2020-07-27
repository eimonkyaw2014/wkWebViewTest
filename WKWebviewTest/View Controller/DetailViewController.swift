//
//  DetailViewController.swift
//  WKWebviewTest
//
//  Created by eimonkyaw on 7/15/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    let sampleURL = "https://developer.apple.com/documentation/webkit/wkwebview/"
    
    private var activityIndicatorContainer : UIView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setToolBar()
        self.sendRequest(urlString: sampleURL)
        // Do any additional setup after loading the view.
    }
    
    private func sendRequest(urlString: String) {
        let myurl = URL(string: sampleURL)
        let request = URLRequest(url: myurl!)
        webView.load(request)
        
    }
    
    fileprivate func setActivityIndicator() {
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicatorContainer.center.x = webView.center.x
        activityIndicatorContainer.center.y = webView.center.y - 44
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorContainer.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainer)
        
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
    }
    
    fileprivate func setToolBar() {
        let  screenWidth = self.view.bounds.width
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolbar.isTranslucent = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.items = [backButton]
        webView.addSubview(toolbar)
        
        toolbar.bottomAnchor.constraint(equalTo: webView.bottomAnchor,constant: 0).isActive = true
        toolbar.leadingAnchor.constraint(equalTo: webView.leadingAnchor,constant: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalTo: webView.trailingAnchor,constant: 0).isActive = true
    }
    
    @objc private func goBack() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicatorContainer.removeFromSuperview()
        }
    }
}

extension DetailViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setActivityIndicator()
        self.showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showActivityIndicator(show: false)
    }
}
