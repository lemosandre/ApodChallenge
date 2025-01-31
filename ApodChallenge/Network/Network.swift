//
//  Network.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Foundation
import Alamofire

enum NetworkError: LocalizedError {
    
    case http(error: Error)
    case custom(description: String)
    case objectSerialization
    
    var errorDescription: String? {
        switch self {
        case let .http(error): return error.localizedDescription
        case let .custom(description): return description
        case .objectSerialization: return "Could not serialize JSON into object."
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}

class Network {

    class func requestArray<T: Decodable>(request: URLRequestConvertible,
                                     type: T.Type,
                                    completion: @escaping (Result<[T]>) -> Void) {
        AF.request(request)
            .responseDecodable(of: [T].self) { response in
                
            switch response.result {
            case let .success(value):
                completion(.success(value))
            case let .failure(error):
                completion(.failure(NetworkError.http(error: error)))
            }
        }
    }
    
    class func requestObject<T: Decodable>(request: URLRequestConvertible,
                                     type: T.Type,
                                    completion: @escaping (Result<T>) -> Void) {
        AF.request(request)
            .responseDecodable(of: T.self) { response in
                
            switch response.result {
            case let .success(value):
                completion(.success(value))
            case let .failure(error):
                completion(.failure(NetworkError.http(error: error)))
            }
        }
    }
}
