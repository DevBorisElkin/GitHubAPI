//
//  ViewController.swift
//  GitHubAPI
//
//  Created by test on 25.06.2022.
//

import UIKit
import RxSwift
import RxCocoa

// check out
// https://docs.github.com/en/rest

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let githubRepository = GitHubRepository()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        githubRepository.getRepos().flatMap { repos -> Observable<[Branch]> in
//            //let randomNumber = Int.random(in: 0...1)
//            let randomNumber = 0
//            let repo = repos[randomNumber]
//            return self.githubRepository.getBranches(ownerName: repo.owner.login, repoName: repo.name)
//        }.bind(to: tableView.rx.items(cellIdentifier: "branchCell", cellType: BranchTableViewCell.self)){
//            index, branch, cell in
//            cell.branchNameLabel.text = branch.name
//        }.disposed(by: disposeBag)
        
        // fix with regular cell filling in
        // https://www.youtube.com/watch?v=C36sb5sc6lE&ab_channel=iOSAcademy
    }


}

struct Repo: Decodable{
    let name: String
    let owner : Owner
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

