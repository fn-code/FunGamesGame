//
//  File.swift
//  
//
//  Created by Ludin Nento on 03/01/21.
//

import Foundation
import FunGamesCore

public struct GameTransformer: MapperEntityResponse {
  
  public typealias Response = GameResponse
  public typealias Entity = FavoriteEntity
  public typealias DomainFavorite = FavoriteDomainModel
  public typealias DomainGame = GameDomainModel
  
  public init() {}
  
  
  public func transformEntitiesToDomain(entities: [FavoriteEntity]) -> [FavoriteDomainModel] {
    return entities.map{ result in
      return FavoriteDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "",
        released: result.released ?? "",
        rating: result.rating ?? 0.0,
        ratingCount: result.ratingCount ?? 0,
        image: result.image ?? ""
      )
    }
  }
  
  public func transformResponsesToDomain(responses: [GameResponse]) -> [GameDomainModel] {
    return responses.map{ result in
      let platforms = result.platforms.map{ res in
        return res.map { res2 in
          return PlatformDomainModel(
            platform: DeviceDomainModel(id: res2.platform.id , name: res2.platform.name),
            releasedAt: res2.releasedAt ?? "",
            requirementsEn: RequirementDomainModel(minimum: res2.requirementsEn?.minimum ?? "", recommended: res2.requirementsEn?.recommended ?? "")
          )
        }
      }
      
      let genres = result.genres.map { genre in
        return genre.map { res in
          return GenresDomainModel(id: res.id, name: res.name)
        }
      }
      
      return GameDomainModel(
        id: result.id,
        name: result.name,
        released: result.released ?? "",
        backgroundImage: result.backgroundImage ?? "",
        rating: result.rating,
        ratingsCount: result.ratingsCount,
        playtime: result.playtime,
        platforms: platforms!,
        genres: genres!
      )
    }
  }
  
  public func transformEntityToDomain(entity: FavoriteEntity) -> FavoriteDomainModel {
    return FavoriteDomainModel(
      id: entity.id ?? 0,
      name: entity.name ?? "",
      released: entity.released ?? "",
      rating: entity.rating ?? 0.0,
      ratingCount: entity.ratingCount ?? 0,
      image: entity.image ?? ""
    )
  }
  
  public func transformDomainToEntity(domain: FavoriteDomainModel) -> FavoriteEntity {
    return FavoriteEntity(
      id: domain.id ?? 0,
      name: domain.name ?? "",
      released: domain.released ?? "",
      rating: domain.rating ?? 0.0,
      ratingCount: domain.ratingCount ?? 0,
      image: domain.image ?? ""
    )
  }
  
  public func transformResponseToDomain(response: GameResponse) -> GameDomainModel {
    let platforms = response.platforms.map{ res in
      return res.map { res2 in
        return PlatformDomainModel(
          platform: DeviceDomainModel(id: res2.platform.id , name: res2.platform.name),
          releasedAt: res2.releasedAt ?? "",
          requirementsEn: RequirementDomainModel(minimum: res2.requirementsEn?.minimum ?? "", recommended: res2.requirementsEn?.recommended ?? "")
        )
      }
    }
    
    let genres = response.genres.map { genre in
      return genre.map { res in
        return GenresDomainModel(id: res.id, name: res.name)
      }
    }
    
    return GameDomainModel(
      id: response.id,
      name: response.name,
      released: response.released ?? "",
      backgroundImage: response.backgroundImage ?? "",
      rating: response.rating,
      ratingsCount: response.ratingsCount,
      playtime: response.playtime,
      platforms: platforms!,
      genres: genres!
    )
  }
  
}
