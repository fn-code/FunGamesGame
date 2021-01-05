//
//  GameResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct GameDomainModel {
  public var id: Int
  public var name: String
  public var released: String?
  public var backgroundImage: String?
  public var rating: Double
  public var ratingsCount: Int
  public var playtime: Int
  public var platforms: [PlatformDomainModel]?
  public var genres: [GenresDomainModel]?
  
  public init(
    id: Int,
    name: String,
    released: String,
    backgroundImage: String,
    rating: Double,
    ratingsCount: Int,
    playtime: Int,
    platforms: [PlatformDomainModel],
    genres: [GenresDomainModel]) {
    self.id = id
    self.name = name
    self.released = released
    self.backgroundImage = backgroundImage
    self.rating = rating
    self.ratingsCount = ratingsCount
    self.playtime = playtime
    self.platforms = platforms
    self.genres = genres
  }
}
