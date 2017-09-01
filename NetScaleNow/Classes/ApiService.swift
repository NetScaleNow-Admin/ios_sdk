import Foundation
import SwiftyJSON

protocol ApiService {
  typealias SubscribeCallback = (Bool, Error?) -> Void
  typealias VoucherCallback = (Voucher?, Error?) -> Void
  typealias CampaignsCallback = ([Campaign]?, Error?) -> Void
  typealias CampaignCallback = (Campaign?, Error?) -> Void
  func campaigns(metadata: Metadata, callback: @escaping CampaignsCallback)
  func campaign(metadata: Metadata, campaign: Campaign, callback: @escaping CampaignCallback)
  func requestVoucher(metadata: Metadata, campaign: Campaign, callback: @escaping VoucherCallback)
  func subscribeToNewsletter(metadata: Metadata, callback: @escaping SubscribeCallback)
}

class ApiServiceImpl: ApiService {
  
  static let shared = ApiServiceImpl()
  
  private init() {}
  
  private let baseUrl = URL(string:"https://staging.cmc.arconsis.com/api")!
  
  private var configuration = URLSessionConfiguration.default
  private var session : URLSession {
    return URLSession(configuration: configuration)
  }
  
  func campaigns(metadata: Metadata, callback: @escaping CampaignsCallback ) {
  
    updateToken {
      let request = self.campaignsRequest(with: metadata)
      self.session.dataTask(with: request, completionHandler: { (data, response, error) in
        
        guard !self.shouldRetry(response: response) else {
          self.campaigns(metadata: metadata, callback: callback)
          return
        }
        
        guard
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200,
          error == nil
        else {
            DispatchQueue.main.async {
              callback(nil, error)
            }
            return
        }
        
        self.parseCampaignData(data: data, callback: callback)
        
      }).resume()
    }
  }
  
  func campaign(metadata: Metadata, campaign: Campaign, callback: @escaping CampaignCallback) {
    
    updateToken {
      let request = self.campaignRequest(for: campaign, metadata: metadata)
      self.session.dataTask(with: request, completionHandler: { (data, response, error) in
        
        guard !self.shouldRetry(response: response) else {
          self.campaign(metadata: metadata, campaign: campaign, callback: callback)
          return
        }
        
        guard
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200,
          error == nil
          else {
            DispatchQueue.main.async {
              callback(nil, error)
            }
            return
        }
        
        let json = JSON(data: data)
        
        let campaign = Campaign(json: json)
        
        DispatchQueue.main.async {
          callback(campaign, nil)
        }
        
      }).resume()
    }
  }
  
  func requestVoucher(metadata: Metadata, campaign: Campaign, callback: @escaping VoucherCallback) {
    updateToken {
      
      let request = self.voucherRequest(for: campaign, metadata: metadata)
      
      self.session.dataTask(with: request, completionHandler: { (data, response, error) in
        
        guard !self.shouldRetry(response: response) else {
          self.requestVoucher(metadata: metadata, campaign: campaign, callback: callback)
          return
        }
        
        guard
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200,
          error == nil
        else {
          DispatchQueue.main.async {
            callback(nil, error)
          }
          return
        }
        
        self.parseVoucherData(data: data, campaign: campaign, callback: callback)
        
      }).resume()
    }
  }
  
  func subscribeToNewsletter(metadata: Metadata, callback: @escaping SubscribeCallback) {
    updateToken {
      
      let request = self.subscribeToNewsletterRequest(with: metadata)
      self.session.dataTask(with: request, completionHandler: { (data, response, error) in
        
        guard !self.shouldRetry(response: response) else {
          self.subscribeToNewsletter(metadata: metadata, callback: callback)
          return
        }
        
        guard
          let response = response as? HTTPURLResponse,
          response.statusCode == 200,
          error == nil
          else {
            DispatchQueue.main.async {
              callback(false, error)
            }
            return
        }
        
        DispatchQueue.main.async {
          callback(true, nil)
        }
        
        
      }).resume()
    }
  }
  
  
  private var retryCount = 0
  private var maxRetryCount = 1
  private func shouldRetry(response: URLResponse?) -> Bool{
    // handle 401 error
    if let response = response as? HTTPURLResponse,
      response.statusCode == 401,
      retryCount < maxRetryCount {
    
        resetToken()
        retryCount += 1
        return true
    }
    
    retryCount = 0
    return false
  }
  
  private func campaignsRequest(with metadata: Metadata) -> URLRequest {
    var url = baseUrl.appendingPathComponent("campaigns")
    url = add(metadata: metadata, to: url)
    
    return URLRequest(url: url)
  }
  
  private func campaignRequest(for campaign:Campaign, metadata: Metadata) -> URLRequest {
    var url = baseUrl.appendingPathComponent("campaigns").appendingPathComponent(campaign.id.description)
    url = add(metadata: metadata, to: url)
    
    return URLRequest(url: url)
  }
  
  private func voucherRequest(for campaign:Campaign, metadata: Metadata) -> URLRequest {
    var url = baseUrl.appendingPathComponent("campaigns").appendingPathComponent(campaign.id.description).appendingPathComponent("voucher")
    url = add(metadata: metadata, to: url)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    return request
    
  }
  
  private func subscribeToNewsletterRequest(with metadata: Metadata) -> URLRequest {
    var url = baseUrl.appendingPathComponent("newsletter").appendingPathComponent("subscribe")
    url = add(metadata: metadata, to: url)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    return request
  }
  
  private func add(metadata: Metadata, to url:URL) -> URL {
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
    urlComponents.queryItems = metadata.queryItems
    return urlComponents.url!
  }
  
  
  fileprivate func parseCampaignData(data: Data, callback: @escaping CampaignsCallback) {
    let json = JSON(data: data).arrayValue
    
    var result = [Campaign]()
    for campaignJson in json {
      result.append(Campaign(json: campaignJson))
    }
    
    DispatchQueue.main.async {
      callback(result, nil)
    }
  }
  
  fileprivate func parseVoucherData(data: Data, campaign: Campaign, callback: @escaping VoucherCallback) {
    let json = JSON(data: data)
    
    var voucher = Voucher(json: json)
    voucher.campaign = campaign
    
    DispatchQueue.main.async {
      callback(voucher, nil)
    }
  }
  
  typealias TokenCallback = () -> Void
  private var token: String?
  private var refreshToken: String?
  private var tokenTimeout: Date?
  private var refreshTokenTimeout: Date?
  
  private func resetToken() {
    token = nil
    refreshToken = nil
    tokenTimeout = nil
    refreshTokenTimeout = nil
  }
  
  private func updateToken(callback: @escaping TokenCallback) {
    
    let tokenValid = token != nil && tokenTimeout != nil && Date() < tokenTimeout!
    let refreshTokenValid = refreshToken != nil && refreshTokenTimeout != nil && Date() < refreshTokenTimeout!
    
    if (tokenValid) {
      callback()
    } else if (refreshTokenValid) {
      refreshToken(refreshToken: refreshToken!, callback: callback)
    } else {
      requestToken(callback: callback)
    }
  }
  
  private func requestToken(callback: @escaping TokenCallback) {
    guard let apiKey = Config.apiKey, let apiSecret = Config.apiSecret else {
      print("Configuration Error: Please specify apiKey and apiSecret")
      return
    }
    
    let url = self.baseUrl.appendingPathComponent("token")
  
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let data = [
      "clientId": "ios-sdk",
      "username": apiKey,
      "password": apiSecret
    ]
    
    request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: [])
    
    performTokenRequest(request: request, callback: callback)
  }
  
  private func refreshToken(refreshToken: String, callback:@escaping  TokenCallback) {
    
    let url = self.baseUrl.appendingPathComponent("token/refresh")
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let data = [
      "clientId": "ios-sdk",
      "refreshToken": refreshToken
    ]
    request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: [])
    
    performTokenRequest(request: request, callback: callback)
  }
  
  private func performTokenRequest(request: URLRequest, callback: @escaping TokenCallback) {
    
    configuration.httpAdditionalHeaders?.removeValue(forKey: "Authorization")
    
    session.dataTask(with: request) { (jsonData, response, error) in
      guard let jsonData = jsonData else { return }
      
      
      let json = JSON(data: jsonData)
      
      self.token = json["access_token"].string
      self.refreshToken = json["refresh_token"].string
      self.tokenTimeout = Date(timeIntervalSinceNow: json["expires_in"].doubleValue)
      self.refreshTokenTimeout = Date(timeIntervalSinceNow: json["refresh_expires_in"].doubleValue)
      
      self.configuration.httpAdditionalHeaders = ["Authorization": "bearer \(self.token!)"]
      
      callback()
      }.resume()
  }
  
}
