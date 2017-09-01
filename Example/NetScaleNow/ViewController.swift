//
//  ViewController.swift
//  NetScaleNow
//
//  Created by jstubenrauch on 06/27/2017.
//  Copyright (c) 2017 jstubenrauch. All rights reserved.
//

import UIKit
import NetScaleNow

class ViewController: UIViewController {
  
  @IBAction func showCampaigns(_ sender: Any) {
    Config.primaryColor = Config.defaultColor
    
    let metadata = Metadata(email: "max.mustermann@email.com")
    metadata.gender = .male
    metadata.zipCode = "12345"
    metadata.firstName = "Max"
    metadata.lastName = "Mustermann"
    
    CampaignManager.showCampaigns(metadata: metadata) {
      print("Finished Voucher Selection")
    }
    
    // It is also possible to show the voucher list without providing metadata
    // CampaignManager.showCampaigns()
    //
    // Or withtout the completion callback.
    // CampaignManager.showCampaigns(metadata: metadata)
  }
  
  @IBAction func showCampaignsTinted(_ sender: Any) {
    
    // You can set the tint color
    
    Config.primaryColor = UIColor.red
    
    let metadata = Metadata(email: "max.mustermann@email.com")
    metadata.gender = .male
    metadata.zipCode = "12345"
    metadata.firstName = "Max"
    metadata.lastName = "Mustermann"
    
    CampaignManager.showCampaigns(metadata: metadata, greeting: "Vielen Dank für Ihre Registrierung") {
      print("Finished Voucher Selection")
    }
  }
}

