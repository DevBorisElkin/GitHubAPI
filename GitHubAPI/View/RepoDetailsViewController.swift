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
    
    var viewModel: TableViewCellViewModel!
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
        guard let url = viewModel.repoURL else {
            print("Something is wrong with repository url")
            return
        }
        
        self.navigationItem.title = viewModel.repoName
        
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    
    
    public func setData(tableViewCellViewModel: TableViewCellViewModel){
        self.viewModel = tableViewCellViewModel
    }
    
    private func shareSelectedRepository(){
        guard let url = viewModel.repoURL else {
            print("Something is wrong with repository url")
            return
        }
        
        let shareVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareVC, animated: true)
    }
}
