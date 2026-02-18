//
//  APIService.swift
//  GithubAPIWrapper
//
//  Created by Rizki Siraj on 09/02/26.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public final class APIService {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let path = "https://api.github.com"
    
    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        
        let urlObject = URL(string: path + url)
        
        let request = URLRequest(url: urlObject!)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                let response = output.response as? HTTPURLResponse
                
                if !(200..<300).contains(response?.statusCode ?? 0) {
                    let body = String(data: output.data, encoding: .utf8)
                    print("BODY:", body ?? "-")
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

@available(iOS 13.0, *)
extension APIService: APIServiceProtocol {}
