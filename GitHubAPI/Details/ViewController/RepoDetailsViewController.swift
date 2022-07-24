//
//  RepoDetailsViewController.swift
//  GitHubAPI
//
//  Created by test on 24.07.2022.
//

import UIKit
import WebKit

class RepoDetailsViewController: UIViewController {
    
    @IBAction func shareButtonPressed(_ sender: Any) { shareSelectedRepository() }
    
    var selectedRepository: Repository?
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func loadWebView(){
        guard let selectedRepository = selectedRepository, let url = URL(string: selectedRepository.html_url) else {
            print("Something is wrong with selected repository or with url to that repository")
            return
        }
        
        self.navigationItem.title = selectedRepository.name
        
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    
    
    public func setData(repository: Repository){
        selectedRepository = repository
    }
    
    private func shareSelectedRepository(){
        guard let selectedRepository = selectedRepository, let url = URL(string: selectedRepository.html_url) else {
            print("Something is wrong with selected repository or with url to that repository")
            return
        }
        
        let shareVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareVC, animated: true)
    }
}
