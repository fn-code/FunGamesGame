//
//  RequirementResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct RequirementDomainModel {
  public var minimum: String?
  public var recommended: String?
  
  public init(minimum: String, recommended: String) {
    self.minimum = minimum
    self.recommended = recommended
  }
}
