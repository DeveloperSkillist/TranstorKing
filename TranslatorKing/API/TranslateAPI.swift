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
        completionHandler: @escaping (String) -> Void
    ) {
        let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt")!
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKeys.id,
            "X-Naver-Client-Secret": APIKeys.Secret
        ]
        
        AF
            .request(url, method: .post, parameters: translateRequestModel, headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translatedText)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
