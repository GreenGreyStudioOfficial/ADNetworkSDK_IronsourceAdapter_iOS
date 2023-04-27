//
//  ISMobidrivenCustomAdapter.swift
//  AD_Demo_App
//
//  Created by Alexander Troitsky on 14.11.2022.
//

import Foundation
import ADNetworkSDK
import IronSource

public class ISMobidrivenCustomAdapter:ISBaseNetworkAdapter {    
    public override func `init` (_ adData: ISAdData, delegate: ISNetworkInitializationDelegate) {
        //print("adData.configuration:")
        //print(adData.configuration)
        if let key = adData.configuration["secret_key"] as? String {
            _ = ADNetworkSDK.shared
            ADNetworkSDK.shared.setKey(key)
            delegate.onInitDidSucceed()
        }
        else {
            delegate.onInitDidFailWithErrorCode(ISAdapterErrors.missingParams.rawValue, errorMessage: "Fail to init ISMobidrivenCustomAdapter")

        }
    }
    
    public override func networkSDKVersion() -> String {
       return  ADNetworkSDK.shared.version()
    }
    public override func adapterVersion() -> String {
       return "1.0"
    }
    
}

