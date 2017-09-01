//
//  Campaign.swift
//  Pods
//
//  Created by Jonas Stubenrauch on 05.05.17.
//
//

import Foundation
import SwiftyJSON


struct Campaign {
  var id: Int
  var name: String
  var discount: String
  var desc: String?
  
  var limitations: String?
  var logoUrl: String?
  var headerUrl: String?
  var shopLink: String?
  var limitationsDescription: String?
  init(json: JSON) {
    id = json["id"].intValue
    name = json["name"].stringValue
    discount = json["value"].stringValue
    
    logoUrl = json["advertiserLogoUrl"].string
    headerUrl = json["campaignImageUrl"].string
    
    if let limits = json["limitations"].string {
      limitations = limits.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    if let limits = json["limitationsDescription"].string {
       limitationsDescription = limits.replacingOccurrences(of: "\\n", with: "\n")
    }
    desc = json["description"].string
    shopLink = json["shopLink"].string
  }
  
  init(id: Int, name: String, discount: String, logoUrl: String?, headerUrl: String?, limitations: String?, description: String?, shopLink: String?) {
    self.id = id
    self.name = name
    self.discount = discount
    self.logoUrl = logoUrl
    self.headerUrl = headerUrl
    self.limitations = limitations
    self.desc = description
    self.shopLink = shopLink
  }
}

