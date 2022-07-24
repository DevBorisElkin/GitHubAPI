//
//  RepoDetailsViewController.swift
//  GitHubAPI
//
//  Created by test on 24.07.2022.
//

import UIKit
import WebKit

class RepoDetailsViewController: UIViewController {
    
    var selectedRepository: Repository?
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
    }
    
    func loadWebView(){
        guard let selectedRepository = selectedRepository, let url = URL(string: selectedRepository.html_url) else {
            print("Something is wrong with selected repository or with url to that repository")
            return
        }
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    public func setData(repository: Repository){
        selectedRepository = repository
    }
}
