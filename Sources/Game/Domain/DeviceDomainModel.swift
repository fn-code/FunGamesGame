//
//  DeviceResponse.swift
//  Fun Games
//
//  Created by Ludin Nento on 14/12/20.
//

import Foundation

public struct DeviceDomainModel: Equatable, Identifiable {
  public var id: Int
  public var name: String
  
  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
