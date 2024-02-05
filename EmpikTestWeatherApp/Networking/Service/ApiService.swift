//
//  ApiService.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

struct ApiService {
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
        Observable.create { observable in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    observable.onNext(.failure(.undefined))
                    return
                }

                let statusCode = httpUrlResponse.statusCode
                
                let code = statusCode
                if 200 ... 205 ~= code, let data = data {
                    observable.onNext(.success(data))
                } else if let error = error {
                    observable.onNext(.failure(.error(error)))
                } else {
                    observable.onNext(.failure(.badRequest))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
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

