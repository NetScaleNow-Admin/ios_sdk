//
//  MockApi.swift
//  Pods
//
//  Created by Jonas Stubenrauch on 22.05.17.
//
//

import Foundation

class MockApiService: ApiService {
  func campaign(metadata: Metadata, campaign: Campaign, callback: @escaping ApiService.CampaignCallback) {
    let c = Campaign(id: 1, name: "Test 1",
                     discount: "10%",
                     logoUrl:"https://corporate.misterspex.com/wp-content/uploads/2015/09/Mister-Spex-Logo-mit-Claim_print.jpg",
                     headerUrl:"https://d26hhearhq0yio.cloudfront.net/content/misterspex/landingpages/2016/09/Blogger_Collection/Desktop/Brandshop/Header-Teaser.jpg",
                     limitations: "- Mindesbestellwert beträgt 50€\n- Nur für Neukunden\n- Elektroartikel ausgeschlossen",
                     description: "Beschreibung des Shops",
                     shopLink: "https://www.misterspex.de"
    );
    callback(c, nil)
  }

  func subscribeToNewsletter(metadata: Metadata, callback: @escaping ApiService.SubscribeCallback) {
    callback(true, nil)
  }

  func campaigns(metadata: Metadata, callback: @escaping CampaignsCallback) {
    let campaigns = [
      
      Campaign(id: 1, name: "Test 1",
               discount: "10%",
               logoUrl:"https://corporate.misterspex.com/wp-content/uploads/2015/09/Mister-Spex-Logo-mit-Claim_print.jpg",
               headerUrl:"https://d26hhearhq0yio.cloudfront.net/content/misterspex/landingpages/2016/09/Blogger_Collection/Desktop/Brandshop/Header-Teaser.jpg",
               limitations: "- Mindesbestellwert beträgt 50€\n- Nur für Neukunden\n- Elektroartikel ausgeschlossen",
               description: "Beschreibung des Shops",
               shopLink: "https://www.misterspex.de"
      ),
      Campaign(id: 2, name: "Test 2", discount: "15%",
               logoUrl:"https://upload.wikimedia.org/wikipedia/commons/5/5f/Mymuesli-logo-RGB.jpg",
               headerUrl:"http://2.bp.blogspot.com/-MTqj0qqQQ64/VeL1fQnCmQI/AAAAAAAAAkE/Lmm-sHbF3YE/s1600/mymuesli5.jpg",
               limitations: "- Mindesbestellwert beträgt 50€\n- Nur für Neukunden\n- Elektroartikel ausgeschlossen",
               description: "Beschreibung des Shops",
               shopLink: "https://www.mymuesli.com"),
      Campaign(id: 3, name: "Test 3", discount: "10 EUR",
               logoUrl:"https://www.gutscheinrausch.de/wp-content/logos/560/planet-sports-de-logo.jpg",
               headerUrl:"https://www.spomo.de/uploads/spomo/news/Planet_Sports_Flagship_Store_Mu__nchen_11-2015_-27.jpg",
               limitations: "- Mindesbestellwert beträgt 50€\n- Nur für Neukunden\n- Elektroartikel ausgeschlossen",
               description: "Beschreibung des Shops",
               shopLink: "https://www.planet-sports.de"),
      Campaign(id: 4, name: "Test 4", discount: "5,- €",
               logoUrl:"http://www.ccl-langenhagen.de/wp-content/uploads/2015/07/130926_Logo_Black_sRGB_Plain_200mm_RZ.jpg",
               headerUrl:"https://www.saarpark-center.de/uploads/tx_ecematrixtables/douglas-shop.JPG",
               limitations: "- Mindesbestellwert beträgt 50€\n- Nur für Neukunden\n- Elektroartikel ausgeschlossen",
               description: "Beschreibung des Shops",
               shopLink: "https://www.douglas.de/douglas/"),
      Campaign(id: 5, name: "Test 5", discount: "5-10%",
               logoUrl:"http://www.cardiffsportexpo.org/wp-content/uploads/2016/03/HelloFresh.png",
               headerUrl:"http://www.treesfullofmoney.com/wp-content/uploads/2016/11/is-hello-fresh-worth-it.png",
               limitations: "- Mindesbestellwert beträgt 50€\n- Nur für Neukunden\n- Elektroartikel ausgeschlossen",
               description: "Beschreibung des Shops",
               shopLink: "https://www.hellofresh.de"),
      
      
    ]
    
    callback(campaigns, nil)
    
  }
  
  func requestVoucher(metadata: Metadata, campaign: Campaign, callback: @escaping VoucherCallback) {
    let voucher = Voucher(code: "ABC-12345", subscribedToNewsletter: false)
    callback(voucher, nil)
  }
}
