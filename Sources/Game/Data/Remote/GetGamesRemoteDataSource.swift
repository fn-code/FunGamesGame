//
//  File.swift
//  
//
//  Created by Ludin Nento on 02/01/21.
//

import Foundation
import FunGamesCore
import RxSwift
import Alamofire

public struct GetGamesRemoteDataSource: GameRemoteDataSource {
  public typealias Request = Any
  
  public typealias Response = GameResponse
  
  private var _enpoints: String
  public init(enpointGame: String) {
    _enpoints = enpointGame
  }
  public func list(page: Int, query: String, page_size: Int) -> Observable<[GameResponse]> {
    return Observable<[GameResponse]>.create { observer in
      if let url = URL(string: "\(_enpoints)") {
        let parameters = ["search": query, "page": String(page), "page_size": String(page_size)]
        AF.request(url, parameters: parameters)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.results)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
        }
      }
      return Disposables.create()
    }
  }
  
  public func get(id: Int) -> Observable<GameResponse> {
    return Observable<GameResponse>.create { observer in
      let urls = String("\(_enpoints)/\(id)")
      if let url = URL(string: urls) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
        }
      }
      return Disposables.create()
    }
  }
  
}
