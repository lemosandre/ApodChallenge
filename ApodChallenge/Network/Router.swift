//
//  Router.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Alamofire
import Foundation

enum Router {
    case apod
    case apodList(startDate: String, endDate: String)
    case apodDate(date: String)
    
    var baseURL: URL {
        URL(string: API.nasaURL)!
    }
    
    var path: String {
        switch self {
        case .apod:
            return API.Path.nasaAPOD
        case .apodList:
            return API.Path.nasaAPOD
        case .apodDate:
            return API.Path.nasaAPOD
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .apod:
            return .get
        case .apodList:
            return .get
        case .apodDate:
            return .get
        }
    }
    
    var parameters: [String: String]  {
        var parameters: [String: String] = [:]

        switch self {
        case .apod:
            parameters[API.DefaultValue.key] = API.Headers.nasaKey
            break
        case let .apodList(startDate, endDate):
            parameters[API.DefaultValue.key] = API.Headers.nasaKey
            parameters[API.DefaultValue.startDate] = startDate
            parameters[API.DefaultValue.endDate] = endDate
            break
        case let .apodDate(date):
            parameters[API.DefaultValue.key] = API.Headers.nasaKey
            parameters[API.DefaultValue.date] = date
            break
        }
        
        return parameters
    }

}

extension Router: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
      
    let url = baseURL.appendingPathComponent(path)
      
    var request = URLRequest(url: url)
      
    request.httpMethod = method.rawValue
    request.timeoutInterval = API.DefaultValue.timeOut
    request.addValue(API.Headers.applicationJson, forHTTPHeaderField: API.Headers.contentType)
    return try URLEncoding.default.encode(request,with: parameters)
  }
}

