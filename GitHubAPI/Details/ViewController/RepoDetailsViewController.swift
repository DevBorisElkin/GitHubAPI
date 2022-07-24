//
//  RepoDetailsViewController.swift
//  GitHubAPI
//
//  Created by test on 24.07.2022.
//

import UIKit
import WebKit

class RepoDetailsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedRepository: Repository?
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        //view.addSubview(webView)
        
        guard let selectedRepository = selectedRepository, let url = URL(string: selectedRepository.html_url) else {
            print("Something is wrong with selected repository or with url to that repository")
            return
        }

        setIndicatorActiveState(state: true)
        
        DispatchQueue.global(qos: .background).async { [weak self, url] in
            self?.webView.load(URLRequest(url: url))
            
            print("code went forward, delay 5")
            sleep(5)
            print("delay passed")
            
            guard let vc = self, let wv = self?.webView else{
                print("error with references")
                return
            }
            
            DispatchQueue.main.async {
                vc.setIndicatorActiveState(state: false)
                vc.view.addSubview(wv)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    public func setData(repository: Repository){
        selectedRepository = repository
    }
    
    private func setIndicatorActiveState(state: Bool){
        if(state){
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
        activityIndicator.isHidden = !state
    }
}
