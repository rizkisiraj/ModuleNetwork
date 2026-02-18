//
//  APIServiceProtocol.swift
//  GithubAPIWrapper
//
//  Created by Rizki Siraj on 17/02/26.
//

import Combine

public protocol APIServiceProtocol {
    @available(iOS 13.0, *)
    func fetchData<T: Decodable>(url: String) -> AnyPublisher<T, Error>
}

