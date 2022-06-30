//
//  ViewController.swift
//  GitHubAPI
//
//  Created by test on 25.06.2022.
//

import UIKit

// check out
// https://docs.github.com/en/rest

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let githubRepository = GitHubRepository()
    
    
    var repos : Repo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            print("Started task")
            repos = try await githubRepository.getRepos()
            print("Owner:\(repos?.owner) | RepoName:\(repos?.name)")
        }
        
        

        
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
    
    func getRepos() async throws -> Repo {
        var result = try await networkService.loadRepos(from: URL(string: "\(baseUrlString)/repositories")!)
        return result
    }
    
//    func getBranches(ownerName: String, repoName: String) -> Observable<[Branch]> {
//        return networkService.execute(url: URL(string: "\(baseUrlString)/repos/\(ownerName)/\(repoName)/branches")!)
//    }
}

class NetworkService{

    public func loadItems<T : Decodable>(from url: URL) async throws -> T {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
    }
    
    public func loadRepos(from url: URL) async throws -> Repo {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(Repo.self, from: data)
    }
}


/*
 //extension ViewController : UITableViewDataSource{
 //
 //   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 //
 //  }
 //
 //  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 //
 // }
 //
 //
 //}
 */
