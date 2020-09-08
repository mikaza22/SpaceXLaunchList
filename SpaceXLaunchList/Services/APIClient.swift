//
//  APIClient.swift
//  SpaceXLaunchList
//
//  Created by Geraldine on 07/09/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import Foundation

// MARK: - LaunchDataServiceDelegate
protocol LaunchDataServiceDelegate: class {
    
    /// Notifies the result of the Launch datas
    func didReceiveLaunchData(_ launchData:[LaunchData])
    
    /// Notifies that an error occured
    func onRequestError(_ error:String)
}

class APICLient {
    
    /// Callback to notify the caller of the request
    weak var delegate: LaunchDataServiceDelegate?
    
    let config = Configuration()
    
    // MARK: - Requests
    
    /// Requests all the launch data
    func getLaunchData() {
        
        getData(urlString: config.apiURL,
                completion: { launchData -> Void in
                    self.delegate?.didReceiveLaunchData(launchData)
        })
    }
    
    func getData<T: Decodable>(urlString: String, completion:@escaping (T) -> Void) {
        
        guard let url = URL(string: urlString) else {
            self.delegate?.onRequestError("Wrong url request: \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let data = data else {
                    self.delegate?.onRequestError("No data found")
                    return
                }
                let launchDatas = try jsonDecoder.decode(T.self, from: data)
                completion(launchDatas)
            } catch {
                self.delegate?.onRequestError(error.localizedDescription)
            }
        }).resume()
    }
}
