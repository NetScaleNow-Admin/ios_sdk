//
//  Strings.swift
//  Pods
//
//  Created by Jonas Stubenrauch on 23.05.17.
//
//

import Foundation

struct Strings {
  private static let bundle = Config.bundle
  
  struct General {
    static var backToCampaignList : String {
      return NSLocalizedString("General.backToCampaignList", bundle: bundle, value: "Zurück zur Übersicht", comment: "Title of the button to go back to the campaign list")
    }
    
    static var agbLink : String {
      return NSLocalizedString("CampaignDetail.agbLink", bundle: bundle, value: "AGB", comment: "Title of the link to open the AGB (Terms of Conditions) ")
    }
    
    static var dataProtectionLink : String {
      return NSLocalizedString("CampaignDetail.dataProtectionLink", bundle: bundle, value: "Datenschutz", comment: "Title of the link to open the data protection ")
    }
    
    static var copyrightLink : String {
      return NSLocalizedString("CampaignDetail.copyrightLink", bundle: bundle, value: "© Premium Shopping", comment: "Title of the link showing the copy right")
    }
    
    static var agbUrl : String {
      return NSLocalizedString("CampaignDetail.agbUrl", bundle: bundle, value: "https://www.premium-shopping.de/agb", comment: "Url to the AGB (Terms of Conditions) ")
    }
    
    static var dataProtectionUrl : String {
      return NSLocalizedString("CampaignDetail.dataProtectionUrl", bundle: bundle, value: "https://www.premium-shopping.de/datenschutz", comment: "Url to the data protection")
    }
    
    static var checkboxPrivacyTermsUrl : String {
      return NSLocalizedString("CampaignDetail.checkboxPrivacyTermsUrl", bundle: bundle, value: "http://www.collaborativemarketingclub.com/datenschutz", comment: "Url to the privacy terms (Datenschutzbedingungen) next to the checkbox")
    }
    
    static var checkboxUsageTermsUrl : String {
      return NSLocalizedString("CampaignDetail.checkboxUsageTermsUrl", bundle: bundle, value: "http://www.collaborativemarketingclub.com/agb", comment: "Url to the usage terms (Nutzungsbedingungen) next to the checkbox")
    }
    
    static var copyrightUrl : String {
      return NSLocalizedString("CampaignDetail.copyrightUrl", bundle: bundle, value: "https://www.premium-shopping.de", comment: "Url to copy right")
    }
  }
  
  struct CampaignList {
    static var headline : String {
      return NSLocalizedString("CampaignList.headline", bundle: bundle, value: "VIELEN DANK FÜR IHREN EINKAUF!", comment: "Headline of the Campaign Selection View")
    }
    
    static var message : String {
      return NSLocalizedString("CampaignList.message", bundle: bundle, value: "Als Dankeschön dürfen Sie sich einen Gratisgutschein aussuchen. ", comment: "Message below the Headline of the Campaign Selection View")
    }
  }
  
  struct CampaignDetail {
    
    private static var discountFormat: String {
      return NSLocalizedString("CampaignDetail.discountFormat", bundle: bundle, value: "%@ Gutschein*", comment: "Discount Value of the Campaign together with Voucher. %@ is replaced with the actual value")
    }
    static func discountFormat(discount: String) -> String {
      return String(format: discountFormat, discount)
    }
    
    static var voucherInformation : String {
      return NSLocalizedString("CampaignDetail.voucherRestrictions", bundle: bundle, value: "*Gutscheinbedingungen", comment: "Title of the voucher information text")
    }
    
    static var checkboxText : String {
      return NSLocalizedString("CampaignDetail.checkboxText", bundle: bundle, value: "Ja, hiermit bestätige ich, dass ich die Nutzungs- und Datenschutzbedingungen gelesen und akzeptiert habe.", comment: "Text shown next to the checkbox.")
    }
    
    static var checkboxTextToHighlightUsage : String {
      return NSLocalizedString("CampaignDetail.checkboxTextToHighlightUsage", bundle: bundle, value: "Nutzungs", comment: "Part of the checkbox text that should be underlined for usage rules")
    }
    
    static var checkboxTextToHighlightData : String {
      return NSLocalizedString("CampaignDetail.checkboxTextToHighlightData", bundle: bundle, value: "Datenschutzbedingungen", comment: "Part of the checkbox text that should be underlined for data protection")
    }
    
    static var emailPlaceholder : String {
      return NSLocalizedString("CampaignDetail.emailPlaceholder", bundle: bundle, value: "E-Mail-Adresse eingeben", comment: "Placeholder for the email input field. Only shows if no email is entered")
    }
    
    static var showVoucher : String {
      return NSLocalizedString("CampaignDetail.showVoucher", bundle: bundle, value: "GUTSCHEINCODE ANZEIGEN", comment: "Title of the button to request a voucher.")
    }
    
    static var backToOverview : String {
      return NSLocalizedString("CampaignDetaill.backToOverview", bundle: bundle, value: "« zurück zur Übersicht", comment: "Title of the button to go back to the campaign list.")
    }
    
    struct TermsActionSheet {
      static var title : String {
        return NSLocalizedString("CampaignDetaill.TermsActionSheet.title", bundle: bundle, value: "Action wählen", comment: "Title of the terms action sheet.")
      }
      
      static var cancel : String {
        return NSLocalizedString("CampaignDetaill.TermsActionSheet.cancel", bundle: bundle, value: "Abbrechen", comment: "Title of the cancel action of the terms action sheet.")
      }
      
      static var optionAccept : String {
        return NSLocalizedString("CampaignDetaill.TermsActionSheet.optionAccept", bundle: bundle, value: "Bedingungen akzeptieren", comment: "Option to accept the terms.")
      }
      
      static var optionShowUsageTerms : String {
        return NSLocalizedString("CampaignDetaill.TermsActionSheet.optionShowUsageTerms", bundle: bundle, value: "Nutzungsbedingungen anzeigen", comment: "Option to show usage terms.")
      }
      
      static var optionShowPrivacyTerms : String {
        return NSLocalizedString("CampaignDetaill.TermsActionSheet.optionShowPrivacyTerms", bundle: bundle, value: "Datenschutzbedingungen anzeigen", comment: "Option to show privacy terms.")
      }
      
    }
  }
  
  struct VoucherDetail {
    static var noNewsletterTitle : String {
      return NSLocalizedString("VoucherDetail.noNewsletterTitle", bundle: bundle, value: "Sie haben Lust auf mehr Gutscheine?", comment: "Title if user has not subscribed to the newsletter yet.")
    }
    
    static var noNewsletterSubTitle : String {
      return NSLocalizedString("VoucherDetail.noNewsletterSubTitle", bundle: bundle, value: "Jetzt zum Newsletter anmelden!", comment: "Message below the Title if user has not subscribed to the newsletter yet.")
    }
    
    static var subscribeToNewsletter : String {
      return NSLocalizedString("VoucherDetail.subscribeToNewsletter", bundle: bundle, value: "KEINE AKTION MEHR VERPASSEN!", comment: "Title of the button to subscribe to the newsletter.")
    }
    
    static var subscribedNewsletterTitle : String {
      return NSLocalizedString("VoucherDetail.subscribedNewsletterTitle", bundle: bundle, value: "Sie wollen noch mehr sparen beim Shoppen?", comment: "Title if user has subscribed to the newsletter.")
    }
    
    static var subscribedNewsletterSubTitle : String {
      return NSLocalizedString("VoucherDetail.subscribedNewsletterSubTitle", bundle: bundle, value: "Suchen Sie sich exklusiv einen weiteren Gutschein aus!", comment: "Message below the Title if user has subscribed to the newsletter.")
    }
    
    static var noVouchersLeftMessage : String {
        return NSLocalizedString("VoucherDetail.noVouchersLeftMessage", bundle: bundle, value: "Sie haben die maximale Anzahl an Gutscheinen erreicht.\nWir halten Sie über neue Gutscheine per Newsletter auf dem Laufenden.\nViel Spaß beim Shoppen!", comment: "Title if user has reached the maxium number of vouchers.")
    }
    
    static var backToCampaignList : String {
      return NSLocalizedString("VoucherDetail.subscribeToNewsletter", bundle: bundle, value: "ZU DEN GUTSCHEINEN", comment: "Title of the button to go back to the campaign list.")
    }
    
    static var checkboxText : String {
      return NSLocalizedString("VoucherDetail.checkboxText", bundle: bundle, value: "Ja, ich möchte künftig den kostenlosen Premium Shopping Newsletter per E-Mail erhalten. Das Einverständnis kann ich jederzeit widerrufen.", comment: "Text shown next to the checkbox.")
    }
    
    static var voucherCodeTitle : String {
      return NSLocalizedString("VoucherDetail.voucherCodeTitle", bundle: bundle, value: "IHR GUTSCHEINCODE", comment: "Title above the voucher code.")
    }
    
    static var linkToShop : String {
      return NSLocalizedString("VoucherDetail.linkToShop", bundle: bundle, value: "Zum Shop »", comment: "Name of the link to the shop of the advertiser.")
    }
    
    static var voucherViaMailHint : String {
      return NSLocalizedString("VoucherDetail.voucherViaMailHint", bundle: bundle, value: "Sie erhalten den Gutschein in wenigen Augenblicken\nzusätzlich per Mail.", comment: "Hint message to indicate the voucher is send via mail.")
    }
    
    struct OpenShopAlert {
      static var title : String {
        return NSLocalizedString("VoucherDetail.OpenShopAlert.title", bundle: bundle, value: "Onlineshop öffnen", comment: "Title of the alert shown before opening the shop url in the browser.")
      }
      
      static var message : String {
        return NSLocalizedString("VoucherDetail.OpenShopAlert.message", bundle: bundle, value: "Sie werden jetzt zum Onlineshop des Anbieters weitergeletet. Der Gutscheincode wird automatisch in die Zwischenablage kopiert.", comment: "Message of the alert shown before opening the shop url in the browser.")
      }
      
      static var cancel : String {
        return NSLocalizedString("VoucherDetail.OpenShopAlert.cancel", bundle: bundle, value: "Abbrechen", comment: "Button of the alert shown before opening the shop url in the browser to not open the shop.")
      }
      
      static var open : String {
        return NSLocalizedString("VoucherDetail.OpenShopAlert.open", bundle: bundle, value: "Öffnen", comment: "Button of the alert shown before opening the shop url in the browser to open the shop.")
      }
    }
    
    
    
  }
}
