//
//  TranslateAPI.swift
//  TranslatorKing
//
//  Created by skillist on 2022/01/25.
//

import RxSwift
import Alamofire

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}

struct TranslateAPI {
   func requestTranslate(
        translateRequestModel: TranslateRequestModel,
//        completionHandler: @escaping (String) -> Void
        completionHandler: @escaping (Result<TranslateResponseModel, AFError>) -> Void
    ) {
        let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt")!
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKeys.id,    //네이버 개발자 사이트에서 발행한 키를 입력하세요.
            "X-Naver-Client-Secret": APIKeys.Secret    //네이버 개발자 사이트에서 발행한 키를 입력하세요.
        ]
        
        AF
            .request(url, method: .post, parameters: translateRequestModel, headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                completionHandler(response.result)
            }
            .resume()
    }
}
