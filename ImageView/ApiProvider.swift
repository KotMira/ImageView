//
//  ApiProvider.swift
//  ImageView
//
//  Created by Пользователь on 26.12.2020.
//

import Moya

let ApiProvider = MoyaProvider<Api>()
enum Api {
    case getImageList(page: Int, limit: Int)
    case getImageInfo(id: Int)
}

extension Api: TargetType {
    var baseURL: URL { URL(string: "https://picsum.photos/")! }
    
    var path: String {
        switch self {
        case .getImageList:
            return "v2/list"
        case .getImageInfo(let id):
            return "id/\(id)/info"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(count: 0)
    }
    
    var task: Task {
        switch self {
        case .getImageList(let page, let limit):
            return .requestParameters(parameters: ["page": page, "limit": limit], encoding: URLEncoding.default)
        case .getImageInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
