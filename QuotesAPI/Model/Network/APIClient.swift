////
//APIClient.swift
//QuotesAPI
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import UIKit
import Alamofire

class APIClient {

    static func getRandomQouteData(completion:@escaping (AFResult<Quote>)->Void){
        AF.request(APIRouter.random)
            .responseDecodable(of: Quote.self) { (response: DataResponse<Quote,AFError>) in
                completion(response.result)

          }

      }
}
