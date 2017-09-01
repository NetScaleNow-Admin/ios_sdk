//
//  CampaignListCollectionViewController.swift
//  Pods
//
//  Created by Jonas Stubenrauch on 18.05.17.
//
//

import UIKit


class CampaignListViewController: UIViewController {
  
  @IBOutlet
  var collectionView: UICollectionView!
  
  @IBOutlet
  var headerBackground: UIView!
  
  @IBOutlet
  var headline: UILabel!
  
  @IBOutlet
  var message: UILabel!
  
    var showingDetails = [IndexPath]()

    
  var closeCallback: (() -> Void)?
  var metadata: Metadata?
  var campaigns: [Campaign]? {
    didSet {
      collectionView?.reloadData()
    }
  }
  
  var greeting : String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateColors()
    updateStrings()
    
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.estimatedItemSize = CGSize(width: 1, height: 1)
  //    layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updatePreferredWidth(for: view.bounds.size)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    collectionView.flashScrollIndicators();
  }

  var preferredWidth: CGFloat!
  func updatePreferredWidth(for size:CGSize) {
    
    let width = preferredWidth(for: size)
    collectionView.visibleCells.forEach { cell in
      if let cell = cell as? CampaignCollectionViewCell {
        cell.preferredWidth = width
      }
    }

    preferredWidth = width
  }
  
  func preferredWidth(for size: CGSize) -> CGFloat {
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
      return 0
    }
    return floor(size.width - layout.sectionInset.left - layout.sectionInset.right - collectionView.contentInset.left - collectionView.contentInset.right)
  }
  
  private func updateColors() {
    headline.textColor = Config.primaryColor
  }
  
  private func updateStrings() {
    headline.text = self.greeting != nil ? self.greeting!.uppercased() : Strings.CampaignList.headline
    message.text = Strings.CampaignList.message
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard
      let detailController = segue.destination as? CampaignDetailViewController,
      let index = collectionView.indexPathsForSelectedItems?.first?.item
      else {
        return
    }
    
    detailController.campaign = campaigns?[index]
    detailController.metadata = metadata
    detailController.closeCallback = closeCallback
  }
  
  @IBAction
  func close() {
    closeCallback?()
  }
  
  @IBAction
  func backToOverview(_: UIStoryboardSegue) {
    
  }
  
}

private let reuseIdentifier = "CampaignCell"
extension CampaignListViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    collectionView.layoutIfNeeded() // fixes crash when initially loaded in landscape
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return campaigns?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CampaignCollectionViewCell
    
    cell.show(campaign: campaigns![indexPath.item])
    cell.showDetails = self.showingDetails.contains(indexPath)
    
    cell.preferredWidth = preferredWidth
    cell.heightChangeCallback = {
      if self.showingDetails.contains(indexPath) {
        self.showingDetails.remove(at: self.showingDetails.index(of: indexPath)!)
      } else {
        self.showingDetails.append(indexPath)
      }
        collectionView.performBatchUpdates({}) { (success) in
          // needs to be called after the cell frame has been updated
//          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//          
//            collectionView.scrollRectToVisible(frame, animated: true)
//          }
        }
    }
    return cell
  }
}
