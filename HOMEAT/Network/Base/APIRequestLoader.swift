//
//  APIRequestLoader.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation
import Alamofire

class APIRequestLoader<T: TargetType> {
    private let configuration: URLSessionConfiguration
    private let apiLogger: APIEventLogger
    private let session: Session
    private let interceptorSession: Session
    let interceptor = HOMEATRequestInterceptor()
    
    init(
        configuration: URLSessionConfiguration = .default,
        apiLogger: APIEventLogger
    ) {
        self.configuration = configuration
        self.apiLogger = apiLogger
        
        self.session = Session(configuration: configuration, eventMonitors: [apiLogger])
        self.interceptorSession = Session(configuration: configuration, interceptor: interceptor, eventMonitors: [apiLogger])
    }
    
    func fetchData<M: Decodable>(
        target: T,
        responseData: M.Type,
        completion: @escaping (NetworkResult<M>) -> Void
    ) {
        var dataRequest = session.request(target)
        
        if target.authorization == .authorization {
            dataRequest = interceptorSession.request(target).validate()
        }
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                
                let networkRequest = self.judgeStatus(by: statusCode, value, type: M.self)
                completion(networkRequest)
            case .failure:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkRequest = self.judgeStatus(by: statusCode, data, type: M.self)
                completion(networkRequest)
            }
        }
    }
    
    func fetchDataWithHeader<M: Decodable>(
        target: T,
        responseData: M.Type,
        completion: @escaping (NetworkResult<M>, [AnyHashable : Any]) -> Void
    ) {
        var dataRequest = session.request(target)
        
        if target.authorization == .authorization {
            dataRequest = interceptorSession.request(target).validate()
        }
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                guard let networkHeader = response.response?.allHeaderFields else { return }
                
                // 필요한 헤더만 추출
                var filteredHeaders: [AnyHashable: Any] = [:]
                if let authorization = networkHeader["Authorization"] {
                    filteredHeaders["Authorization"] = authorization
                }
                if let setCookie = networkHeader["Set-Cookie"] {
                    filteredHeaders["Set-Cookie"] = setCookie
                }

                let networkRequest = self.judgeStatus(by: statusCode, value, type: M.self)
                completion(networkRequest, filteredHeaders)
            case .failure:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                
                let networkRequest = self.judgeStatus(by: statusCode, data, type: M.self)
                completion(networkRequest, [:])
            }
        }
    }
    
    private func judgeStatus<M: Decodable>(by statusCode: Int, _ data: Data, type: M.Type) -> NetworkResult<M> {
        switch statusCode {
        case 200...299: return isValidData(data: data, type: M.self)
        case 400, 402...499: return isValidData(data: data, type: M.self)
        case 500: return .serverErr
        default: return .networkErr
        }
    }
    
    private func isValidData<M: Decodable>(data: Data, type: M.Type) -> NetworkResult<M> {
        let decoder = JSONDecoder()
        do {
            let members = try decoder.decode(M.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
            print(error.localizedDescription)
        }
        guard let decodedData = try? decoder.decode(M.self, from: data) else {
            print("json decoded failed !")
            return .pathErr
        }
        
        return .success(decodedData)
    }
}
