//
//  PlatformResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct PlatformResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case platform
    case releasedAt = "released_at"
    case requirementsEn = "requirements"
  }
  
  var platform: DeviceResponse
  var releasedAt: String?
  var requirementsEn: RequirementResponse?
}
