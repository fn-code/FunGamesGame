//
//  PlatformResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct PlatformDomainModel {
  public var platform: DeviceDomainModel
  public var releasedAt: String?
  public var requirementsEn: RequirementDomainModel?
  
  public init(platform: DeviceDomainModel, releasedAt: String, requirementsEn: RequirementDomainModel) {
    self.platform = platform
    self.releasedAt = releasedAt
    self.requirementsEn = requirementsEn
  }
}
