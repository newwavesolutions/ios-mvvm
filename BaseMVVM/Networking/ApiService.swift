//
//  AppAPI.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/25/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Alamofire

enum ApiService {
    
    // MARK: - Authentication
    case login(username: String, password: String)
    case register(username: String, password: String)
    // MARK: - Profile
    case getProfile
    // MARK: - Item
    case getItems(page: Int, pageSize: Int)
    // MARK: Upload/Download
    case uploadAvatar(data: Data)
    case downloadAvatar(contentPath: String)
}

extension ApiService: TargetType {
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: Configs.Network.apiBaseUrl)!
        case .downloadAvatar:
            return URL(string: "https://upload.wikimedia.org")!
        case .uploadAvatar:
            return URL(string: Configs.Network.apiBaseUrl)!
        default:
            return URL(string: Configs.Network.apiBaseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .login( _, _):
            return "/api/login"
        case .register( _, _):
            return "/api/register"
        case .getItems:
            return "/3/discover/movie"
        case .getProfile:
            return "/api/user"
        case .uploadAvatar:
            return "/api/user/avatar"
        case .downloadAvatar:
            return "/wikipedia/commons/4/4e/Pleiades_large.jpg"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .uploadAvatar:
            return .post
        default:
            return .get
        }
    }
    
    var headers: [String : String]? {
        if let accessToken = AuthManager.shared.token?.accessToken {
            return ["Authorization": "Bearer \(accessToken)"]
        }
        return nil
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        case .login(let username, let password):
            params["username"] = username
            params["password"] = password
        case .register(let username, let password):
            params["username"] = username
            params["password"] = password
        case .getItems(let page, let pageSize):
            params["api_key"] = Configs.Network.apiKey
            params["page"] = page
            params["pageSize"] = pageSize
        default: break
        }
        return params
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getProfile:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getItems:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .uploadAvatar(let data):
            let multipartFormData = [MultipartFormData(provider: .data(data), name: "file", fileName: "image.png", mimeType: "image/png")]
            return .uploadCompositeMultipart(multipartFormData, urlParameters: ["api_key": "dc6zaTOxFJmzC", "username": "Moya"])
        case.downloadAvatar:
            return .downloadDestination(defaultDownloadDestination)
        default:
            return .requestPlain
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        case .login:
            return .successCodes
        default:
            return .successCodes
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return readJSONFromFile("MockSignIn")
        case .register:
            return readJSONFromFile("MockSignIn")
        case .getItems:
            return "{}".data(using: .utf8)!
        case .getProfile:
            return readJSONFromFile("MockProfile")
        default:
            return "{}".data(using: .utf8)!
        }
    }
}

// MARK: - Read file JSON for sample data
private func readJSONFromFile(_ fileName: String) -> Data {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let fileUrl = URL(fileURLWithPath: path)
            // Getting data from JSON file using the file URL
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            return data
        } catch {
            // Handle error here
            return "{}".data(using: .utf8)!
        }
    }
    return "{}".data(using: .utf8)!
}

private let defaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    if !directoryURLs.isEmpty {
        let customFilename = Date().iso8601String
        guard let suggestedFilename = response.suggestedFilename else {
            fatalError("@Moya/contributor error!! We didn't anticipate this being nil")
        }
        //        return (directoryURLs[0].appendingPathComponent(suggestedFilename), [])
        return (directoryURLs[0].appendingPathComponent(customFilename), [])
    }
    
    return (temporaryURL, [])
}
