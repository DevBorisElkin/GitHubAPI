//
//  ViewController.swift
//  GitHubAPI
//
//  Created by test on 25.06.2022.
//

import UIKit
import RxSwift

// check out
// https://docs.github.com/en/rest

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let githubRepository = GitHubRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        githubRepository.getRepos()
        
    }


}

struct Repo: Decodable{
    let name: String
}

struct Owner: Decodable{
    let login: String
}

struct Branch: Decodable{
    let name: String
}

class GitHubRepository{
    private let networkService = NetworkService()
    private let baseUrlString = "https://api.github.com"
    
    func getRepos() -> Observable<[Repo]> {
        return networkService.execute(url: URL(string: "\(baseUrlString)/repositories")!)
    }
    
    func getBranches(ownerName: String, repoName: String) -> Observable<[Branch]> {
        return networkService.execute(url: URL(string: "\(baseUrlString)/repos/\(ownerName)/\(repoName)/branches")!)
    }
}

class NetworkService{
    func execute<T : Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else { return }
                
                observer.onNext(decoded)
                observer.onCompleted()
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
            
        }
    }
}

