//
//  File.swift
//  
//
//  Created by Ludin Nento on 02/01/21.
//

import Foundation

public struct FavoriteDomainModel: Equatable, Identifiable {
  public var id: Int64?
  public var name: String?
  public var released: String?
  public var rating: Double?
  public var ratingCount: Int64?
  public var image: String?
  
  public init(id: Int64, name: String, released: String, rating: Double, ratingCount: Int64, image: String) {
    self.id = id
    self.name = name
    self.released = released
    self.rating = rating
    self.ratingCount = ratingCount
    self.image = image
  }
}
