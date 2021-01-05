//
//  GamesResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct GamesResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
      case count
      case next
      case previous
      case seoTitle = "seo_title"
      case results = "results"
  }
  
  var count: Int
  var next: String?
  var previous: String?
  var seoTitle: String?
  var results: [GameResponse]
}
