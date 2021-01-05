//
//  GameResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct GameResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
      case id
      case name
      case released
      case backgroundImage = "background_image"
      case rating
      case ratingsCount = "ratings_count"
      case playtime
      case platforms
      case genres = "genres"
  }
  
  var id: Int
  var name: String
  var released: String?
  var backgroundImage: String?
  var rating: Double
  var ratingsCount: Int
  var playtime: Int
  var platforms: [PlatformResponse]?
  var genres: [GenreResponse]?
}
