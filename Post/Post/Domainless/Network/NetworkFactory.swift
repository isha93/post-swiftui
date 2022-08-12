//
//  NetworkFactory.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation
//
//  Endpoint.swift
//  SwiftUI-MVVM
//
//  Created by isa nur fajar on 18/01/22.
//

import Foundation
import SwiftUI

enum NetworkFactory {
    case getPost(page: Int)
    case getUser
}

extension NetworkFactory {
    
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .getPost(let page):
            return "/posts/page\(page)"
        case .getUser:
            return "/users"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .getPost, .getUser:
            return []
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        default:
            return "3fc7b134-bc49-4118-a5bc-82472c90a981.mock.pstmn.io"
        }
    }
    
    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        let finalParams: [URLQueryItem] = self.queryItems
        components.path = path
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        default:
            return .get
        }
    }
    
    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    // MARK: BODY PARAMS API
    var bodyParam: [String: Any]? {
        switch self {
        default:
            return [:]
        }
    }
    
    // MARK: MULTIPART DATA
    var data: Data? {
        switch self {
        default:
            return Data()
        }
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .getPost, .getUser:
            return getHeaders(type: .anonymous)
        }
    }
    // MARK: TYPE OF HEADER
    enum HeaderType {
        case anonymous
        case authorized
        case appToken
        case multiPart
    }
    
    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        
        let appToken = UserDefaults.standard.string(forKey: "UserToken")
        
        var header: [String: String]
        
        switch type {
        case .anonymous:
            header = [:]
        case .authorized:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "Authorization": "Basic \(setupBasicAuth())"]
        case .appToken:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "x-lapakibu-token": "\(appToken ?? "")",
                      "agree-mart-token": "\(appToken ?? "")"]
        case .multiPart:
            let boundary = generateBoundaryString()
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*",
                      "x-lapakibu-token": "\(appToken ?? "")"]
        }
        return header
    }
    
    
    private func setupBasicAuth() -> String {
        let username = ""
        let password = ""
        let loginString = "\(username):\(password)"
        
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return ""
        }
        let base64LoginString = loginData.base64EncodedString()
        
        return base64LoginString
    }

    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(withJSONObject: bodyParam, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                // swiftlint:disable disable_print
                #if DEBUG
                print(error)
                #endif
                // swiftlint:enable disable_print
            }
        }
        return urlRequest
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}
