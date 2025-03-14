//
//  OnboardingService.swift
//  HOMEAT
//
//  Created by 강석호 on 4/29/24.
//

import Foundation

protocol OnboardingServiceProtocol {
    func kakaoLogin(bodyDTO: KakaoLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void)
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void)
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void)
    func emailLogin(bodyDTO: EmailLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailLoginResponseDTO>>) -> Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    
    func kakaoLogin(bodyDTO: KakaoLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void) {
        fetchData(target: .kakaoLogin(bodyDTO),
                  responseData: BaseResponse<KakaoLoginResponseDTO>.self, completion: completion)
    }
    
    func userInfo(completion: @escaping (NetworkResult<BaseResponse<UserInfoResponseDTO>>) -> Void) {
        fetchData(target: .userInfo,
                  responseData: BaseResponse<UserInfoResponseDTO>.self, completion: completion)
    }
    
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void) {
        fetchData(target: .postRefreshToken, responseData: BaseResponse<TokenRefreshResponseDTO>.self, completion: completion)
    }
    
    func emailLogin(bodyDTO: EmailLoginRequestBodyDTO, completion: @escaping (NetworkResult<BaseResponse<EmailLoginResponseDTO>>) -> Void) {
        fetchDataWithHeader(target: .emailLogin(bodyDTO),
                            responseData: BaseResponse<EmailLoginResponseDTO>.self, completion: { (result, headers) in
            // 여기에서 필요한 작업을 수행하고 최종 결과를 `completion`으로 넘깁니다.
            completion(result)
            print(headers)
        })
    }
}
