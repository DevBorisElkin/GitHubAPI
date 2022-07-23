//
//  HelpersAPI.swift
//  GitHubAPI
//
//  Created by test on 30.06.2022.
//

import Foundation

public class HelpersAPI{
    
    public static func getRepoData(url: String){
        Task{
            var repo = try await loadRepo(from: URL(string: url)!)
            repo.printMainData()
        }
    }
    
    public static func loadRepo(from url: URL) async throws -> RepoSimplified {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(RepoSimplified.self, from: data)
    }
    
    public static func printRepositoryFromUrl(from url:String){
        var task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("Couldn't get data from URL")
                return
            }
            print("__________")
            
            var json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let json = json{
                print(json)
            }
            
            print("__________")
            var result:RepoSimplified?
            
            do{
                result = try JSONDecoder().decode(RepoSimplified.self, from: data)
            }catch{
                print("Error decoding data: \(error)")
            }

            guard let json = result else{
                print("Unknown error, returning")
                return
            }
            
            json.printMainData()
        }
        task.resume()
        
    }
    
    public static func printReposFromUrl(from url:String){
        var task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("Couldn't get data from URL")
                return
            }
            
            var json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json!)
            
            var result: Repositories? = try? JSONDecoder().decode(Repositories.self, from: data)
            
            guard let result = result else{
                print("Error decoding to Repositories type")
                return
            }
            print(result)
//            var result: RepoArray?
//
//            do{
//                result = try JSONDecoder().decode(RepoArray.self, from: data)
//            }catch{
//                print("Error decoding data: \(error)")
//            }
//
//            guard let json = result else{
//                print("Unknown error, returning")
//                return
//            }
//
//            print(result)
//            for item in json{
////                item.printMainData()
//                print(item)
//            }
        }
        task.resume()
        
    }
    
}

public struct RepoArray : Decodable{
    var repos: [RepoSimplified]
}

public struct RepoSimplified : Decodable{
    var login: String
    var id: Int
    var node_id: String
    var avatar_url: String
    var gravatar_id: String
    var url: String
    var html_url: String
    var followers_url: String
    var following_url: String
    var gists_url: String
    var starred_url: String
    var subscriptions_url: String
    var organizations_url: String
    var repos_url: String
    var events_url: String
    var received_events_url: String
    var type: String
    var site_admin: Bool
    var name: String
    var company: String?
    var blog: String
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String
    var twitter_username: String?
    var public_repos: Int
    var public_gists: Int
    var followers: Int
    var following: Int
    var created_at: String
    var updated_at: String
    
    public func printMainData(){
        print("\(name)")
        print("\(id)")
        print("\(login)")
        print("\(email)")
    }
}
