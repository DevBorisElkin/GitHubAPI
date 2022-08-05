//
//  Repository.swift
//  GitHubAPI
//
//  Created by test on 23.07.2022.
//

import Foundation

struct Repository: Decodable{
    var id: Int
    var name: String
    var owner: RepositoryOwner
    var description: String?
    var html_url: String
}
