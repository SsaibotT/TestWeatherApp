//
//  ApiService.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

struct ApiClient {
    func procedure(
        api: ApiValue,
        params: BaseRequestParams? = nil
    ) -> Observable<ApiResult> {
        guard let request = makeRequest(
            urlString: api.path,
            headers: api.headers,
            params: params?.parameters,
            requestType: .get
        ) else { return Observable.error(ApiError.undefined) }
        
        switch api.type {
        case .get:
            return get(request: request)
        default:
            print("Implement other cases")
            return Observable.error(ApiError.undefined)
        }
    }
    
    private func get(request: URLRequest) -> Observable<ApiResult> {
        URLSession.shared.rx
            .response(request: request)
            .map { result -> ApiResult in
                let statusCode = result.response.statusCode
                
                let code = statusCode
                if 200 ... 205 ~= code {
                    return .success(result.data)
                } else if 503 == code {
                    return .failure(.limitedResponse)
                } else {
                    return .failure(.badRequest)
                }
            }
            .observe(on: MainScheduler.asyncInstance)
    }
    
    private func makeRequest(urlString: String, headers: ApiHeaders, params: [String: Any]?, requestType: ApiReqeustType) -> URLRequest? {
        guard var url = URL(string: urlString) else { return nil }
        
        if let params = params {
            guard var urlComponents = URLComponents(string: urlString) else {
                return nil
            }
            
            urlComponents.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            
            guard let urlWithComponents = urlComponents.url else { return nil }
            url = urlWithComponents
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

