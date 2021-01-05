//
//  File.swift
//  
//
//  Created by Ludin Nento on 02/01/21.
//

import FunGamesCore
import RxSwift

public struct GetGamesRepository<
  LocalDataSource: FavoriteLocalDataSource,
  RemoteDataSource: GameRemoteDataSource,
  Transformer: MapperEntityResponse> : GameRepository

where
  LocalDataSource.Response == FavoriteEntity,
  RemoteDataSource.Response == GameResponse,
  Transformer.Response == GameResponse,
  Transformer.Entity == FavoriteEntity,
  Transformer.DomainGame == GameDomainModel,
  Transformer.DomainFavorite == FavoriteDomainModel {
  
  public typealias RequestFavorite = FavoriteDomainModel
  public typealias ResponseGame = GameDomainModel
  public typealias ResponseFavorite = FavoriteDomainModel
  
  private let _localeDataSource: LocalDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
      localeDataSource: LocalDataSource,
      remoteDataSource: RemoteDataSource,
      mapper: Transformer) {
      
      _localeDataSource = localeDataSource
      _remoteDataSource = remoteDataSource
      _mapper = mapper
  }
  
  public func getGames(page: Int, query: String, pageSize: Int) -> Observable<[GameDomainModel]> {
      return _remoteDataSource.list(page: page, query: query, page_size: pageSize)
        .map { _mapper.transformResponsesToDomain(responses: $0) }
  }
  
  public func getGame(id: Int) -> Observable<GameDomainModel> {
    return _remoteDataSource.get(id: id)
      .map{ _mapper.transformResponseToDomain(response: $0)}
  }
  
  public func getFavorites() -> Observable<[FavoriteDomainModel]> {
      return _localeDataSource.list(request: nil)
        .map{ _mapper.transformEntitiesToDomain(entities: $0)}
  }
  
  public func getFavorite(id: Int) -> Observable<FavoriteDomainModel> {
    return _localeDataSource.get(id: id)
      .map{ _mapper.transformEntityToDomain(entity: $0 )}
  }
  
  public func addFovorite(favorite: FavoriteDomainModel) -> Observable<Bool> {
    return _localeDataSource.add(entity: _mapper.transformDomainToEntity(domain: favorite))
  }
  
  public func deleteFovorite(id: Int) -> Observable<Bool> {
      return _localeDataSource.delete(id: id)
  }
}
