//
//  Voucher.swift
//  Pods
//
//  Created by Jonas Stubenrauch on 23.05.17.
//
//

import Foundation
import SwiftyJSON


struct Voucher {
  var code: String
  var subscribedToNewsletter = false
  var campaign: Campaign?
  
  init(code: String, subscribedToNewsletter: Bool) {
    self.code = code
    self.subscribedToNewsletter = subscribedToNewsletter
  }
  
  init(json: JSON) {
    code = json["code"].stringValue
    subscribedToNewsletter = json["hasSubscribedToNewsletter"].boolValue
  }
}
