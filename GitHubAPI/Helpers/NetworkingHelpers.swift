//
//  NetworkingHelpers.swift
//  JSONParsingPlayground
//
//  Created by test on 23.07.2022.
//

import Foundation

public class NetworkingHelpers{
    
    public static func decodeData<T: Decodable>(from url: String, type: T.Type, printJSON: Bool, completion: @escaping (T) -> ()){
        
        loadDataFromURL(from: url, printJSON: printJSON) { data in
            guard let result = try? JSONDecoder().decode(type.self, from: data) else{
                print("\(#function) Couldn't decode data properly")
                return
            }
            completion(result)
        }
    }
    
    public static func loadDataFromURL(from url: String, printJSON: Bool, completion: @escaping (Data) -> ()){
        
        var task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("\(#function) Couldn't load data from URL")
                if let error = error {
                    print(error)
                }
                return
            }
            
            if printJSON, var json = try? JSONSerialization.jsonObject(with: data, options: []){
                print("-----JSON Retrieved-----\n\(json)\n-----JSON Ended-----")
            }
            
            DispatchQueue.main.async{
                completion(data)
            }
        }
        task.resume()
    }
}
