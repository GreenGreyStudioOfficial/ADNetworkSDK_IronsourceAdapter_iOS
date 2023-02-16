//
//  ISMobidrivenCustomRewardedVideo.swift
//  AD_Demo_App
//
//  Created by Alexander Troitsky on 14.11.2022.
//

import Foundation
//import ADNetworkSDK

@objc(ISMobidrivenCustomRewardedVideo)
public class ISMobidrivenCustomRewardedVideo : ISBaseRewardedVideo {
    private var adDelegate:ISRewardedVideoAdDelegate?
    
    public override func loadAd(with adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
        self.adDelegate = delegate
        self.addObserver()
        ADNetworkSDK.shared.load(rewarded: true, mraid: false)
    }
    
    public override func isAdAvailable(with adData: ISAdData) -> Bool {
       return false
    }
    
    public override func showAd(with viewController: UIViewController, adData: ISAdData, delegate: ISRewardedVideoAdDelegate) {
       if !isAdAvailable(with: adData) {
          delegate.adDidFailToShowWithErrorCode(ISAdapterErrors.internal.rawValue, errorMessage: "ad is not ready to show for the current instanceData")
          return
       }

       showRewardedVideoAd(withInstanceData: adData)
    }
    
    private func showRewardedVideoAd (withInstanceData:ISAdData) {
        // print("ISMobidrivenCustomRewardedVideo showAd")
    }
    
    func destroy() {
        NotificationCenter.default.removeObserver(self)
        self.adDelegate = nil
    }
    
    deinit {
        destroy()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.processADNetworkSDKEvent),
            name: NSNotification.Name(rawValue: "ADNetworkSDKEvent"),
            object: nil
        )
    }
    
    @objc func processADNetworkSDKEvent(notification:NSNotification) {
        guard let userInfo = notification.userInfo as? [String:Any], let eventType = userInfo["eventType"] as? String else {return}
        switch eventType {
        case "start":
            self.adDelegate?.adDidStart()
        case "click":
            self.adDelegate?.adDidClick()
        case "complete":
            self.adDelegate?.adDidEnd()
        case "close":
            self.adDelegate?.adDidClose()
        case "fail":
            self.adDelegate?.adDidFailToLoadWith(.internal, errorCode: 0, errorMessage: nil)
        default:
            return
        }
    }

}

extension ISMobidrivenCustomRewardedVideo: ISRewardedVideoAdDelegate {
    // Mandatory
    
    public func adRewarded() {
        // print("ISRewardedVideoAdDelegate adRewarded")
    }
    
    public func adDidOpen() {
        // print("ISRewardedVideoAdDelegate adDidOpen")
    }
    
    public func adDidClose() {
        // print("ISRewardedVideoAdDelegate adDidClose")
    }
    
    public func adDidFailToShowWithErrorCode(_ errorCode: Int, errorMessage: String?) {
        print("ISRewardedVideoAdDelegate adDidFailToShowWithErrorCode: \(errorCode)")
        if let err = errorMessage {
            print(err)
        }
    }
    
    public func adDidShowSucceed() {
        // print("ISRewardedVideoAdDelegate adDidShowSucceed")
    }
    
    public func adDidBecomeVisible() {
        // print("ISRewardedVideoAdDelegate adDidBecomeVisible")
    }
    
    public func adDidStart() {
        // print("ISRewardedVideoAdDelegate adDidStart")
    }
    
    public func adDidEnd() {
        // print("ISRewardedVideoAdDelegate adDidEnd")
    }
    
    public func adDidLoad() {
        // print("ISRewardedVideoAdDelegate adDidLoad")
    }
    
    public func adDidFailToLoadWith(_ errorType: ISAdapterErrorType, errorCode: Int, errorMessage: String?) {
        print("ISRewardedVideoAdDelegate adDidFailToShowWithErrorCode: \(errorCode)")
        if let err = errorMessage {
            print(err)
        }
    }
    
    public func adDidClick() {
        // print("ISRewardedVideoAdDelegate adDidClick")
    }
}
