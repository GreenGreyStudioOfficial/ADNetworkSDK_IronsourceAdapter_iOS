//
//  ISMobidrivenCustomInterstitial.swift
//  AD_Demo_App
//
//  Created by Alexander Troitsky on 14.11.2022.
//

import Foundation
//import ADNetworkSDK

@objc(ISMobidrivenCustomInterstitial)
public class ISMobidrivenCustomInterstitial  : ISBaseInterstitial {
    
    private var adDelegate:ISInterstitialAdDelegate?
    
    public override func loadAd(with adData: ISAdData, delegate: ISInterstitialAdDelegate) {
        self.adDelegate = delegate
        self.addObserver()
        ADNetworkSDK.shared.load(rewarded: false, mraid: false)
    }
    
    public override func isAdAvailable(with adData: ISAdData) -> Bool {
       
       return false
    }
    
    public override func showAd(with viewController: UIViewController, adData: ISAdData, delegate: ISInterstitialAdDelegate) {
        if !isAdAvailable(with: adData) {
          delegate.adDidFailToShowWithErrorCode(ISAdapterErrors.internal.rawValue, errorMessage: "ad is not ready to show for the current instanceData")
          return
       }

       showAd(withInstanceData: adData)
    }
    
    private func showAd (withInstanceData:ISAdData) {
        // print("ISMobidrivenCustomInterstitial showAd")
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

extension ISMobidrivenCustomInterstitial:ISInterstitialAdDelegate {
    // Mandatory
    public func adDidLoad() {
        // print("ISInterstitialAdDelegate adDidLoad")
        
    }
    
    public func adDidFailToLoadWith(_ errorType: ISAdapterErrorType, errorCode: Int, errorMessage: String?) {
        print("ISInterstitialAdDelegate adDidFailToLoadWith: \(errorCode)")
        if let err = errorMessage {
            print(err)
        }
    }
    
    public func adDidOpen() {
        // print("ISInterstitialAdDelegate adDidOpen")
    }
    
    public func adDidClose() {
        // print("ISInterstitialAdDelegate adDidClose")
    }
    
    public func adDidFailToShowWithErrorCode(_ errorCode: Int, errorMessage: String?) {
        print("ISInterstitialAdDelegate adDidFailToShowWithErrorCode: \(errorCode)")
        if let err = errorMessage {
            print(err)
        }
    }
    
    // Optional
    public func adDidShowSucceed() {
        // print("ISInterstitialAdDelegate adDidShowSucceed")
    }
    
    public func adDidBecomeVisible() {
        // print("ISInterstitialAdDelegate adDidBecomeVisible")
    }
    
    public func adDidStart() {
        // print("ISInterstitialAdDelegate adDidStart")
    }
    
    public func adDidEnd() {
        // print("ISInterstitialAdDelegate adDidEnd")
    }
    
    public func adDidClick() {
        // print("ISInterstitialAdDelegate adDidClick")
    }
}
