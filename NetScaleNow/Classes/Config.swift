//
//  Config.swift
//  Pods
//
//  Created by Jonas Stubenrauch on 05.05.17.
//
//

import Foundation


/// Used to customize the appearance of this component
public struct Config {
  public static let defaultColor = UIColor(red: 0.75, green: 0.62, blue: 0.35, alpha: 1)
  
  
  /// The apiKey for the MobileNetwork Api.
  public static var apiKey: String?
  /// The apiSecret for the MobileNetwork Api.
  public static var apiSecret: String?
  
  /// This is the tint color of the Campaign/Voucher selection. Use this property to make the ui match your design.
  public static var primaryColor: UIColor = Config.defaultColor;
  
  internal static var bundle: Bundle {
    let frameworkBundle = Bundle(for: CampaignManager.self)
    let bundlePath = frameworkBundle.path(forResource: "NetScaleNow", ofType: "bundle")!
    return Bundle(path: bundlePath)!
  }
  
  internal static var maxNumberOfVouchers = 2
}
