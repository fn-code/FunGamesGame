//
//  File.swift
//  
//
//  Created by Ludin Nento on 03/01/21.
//

import Foundation

public struct GenresDomainModel: Equatable, Identifiable {
  public var id: Int
  public var name: String
  
  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
