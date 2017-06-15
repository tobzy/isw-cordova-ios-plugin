//
//  Created by Efe Ariaroo on 10/05/2016.
//  Copyright © 2016 Interswitch Limited. All rights reserved.

import UIKit
import PaymentSDK
import SwiftyJSON


@objc(PaymentPlugin) class PaymentPlugin : CDVPlugin {
    internal var clientId : String = ""
    internal var clientSecret : String = ""
    
    
    func Init (_ command: CDVInvokedUrlCommand) {
        let firstArg = command.arguments[0] as? [String:AnyObject]
        
        let theClientId = Utils.getStringFromDict(firstArg!, theKey: "clientId")
        let theClientSecret = Utils.getStringFromDict(firstArg!, theKey: "clientSecret")
        let paymentApi = Utils.getStringFromDict(firstArg!, theKey: "paymentApi")
        let passportApi = Utils.getStringFromDict(firstArg!, theKey: "passportApi")
        
        if paymentApi.length > 0 && passportApi.length > 0 {
            Payment.overrideApiBase(paymentApi)
            Passport.overrideApiBase(passportApi)
        }
        if theClientId.length > 0 && theClientSecret.length > 0 {
            self.clientId = theClientId
            self.clientSecret = theClientSecret
        }
    }
    
    
    //---------- With SDK UI
    
    
    func PayWithCard(_ cdvCommand: CDVInvokedUrlCommand) {
        let firstArg = cdvCommand.arguments[0] as? [String:AnyObject]
        
        let customerIdAsString = Utils.getStringFromDict(firstArg!, theKey: "customerId")
        let amountAsString = Utils.getStringFromDict(firstArg!, theKey: "amount")
        //--
        let theCurrency = firstArg?["currency"] as? String
        let theDescription = firstArg?["description"] as? String
        
        PayWithUI.payWithCard(self, command: cdvCommand, theCustomerId: customerIdAsString, theCurrency: theCurrency!,
                              theDescription: theDescription!, theAmount: amountAsString)
    }
    
    
}

extension String {
    var length: Int {
        return (self as NSString).length
    }
}
