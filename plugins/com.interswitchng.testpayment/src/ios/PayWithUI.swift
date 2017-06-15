//
//  Created by Efe Ariaroo on 10/05/2016.
//  Copyright © 2016 Interswitch Limited. All rights reserved.

import UIKit
import PaymentSDK


open class PayWithUI {
    fileprivate static var cdvPlugin : PaymentPlugin?
    fileprivate static var currentVc : UIViewController?
    fileprivate static var isSdkVcShownUsingWindow  = false
    fileprivate static var window : UIWindow?
    

    
    class func payWithCard(_ cdvPlugin: PaymentPlugin, command: CDVInvokedUrlCommand,
                           theCustomerId: String, theCurrency:String, theDescription:String, theAmount:String) {
        PayWithUI.cdvPlugin = cdvPlugin
        
        let payWithCard = PayWithCard(clientId: cdvPlugin.clientId, clientSecret: cdvPlugin.clientSecret,
                                      customerId: theCustomerId, description: theDescription,
                                      amount:theAmount, currency:theCurrency)
        
        let vc = payWithCard.start({(purchaseResponse: PurchaseResponse?, error: Error?) in
            guard error == nil else {
                let errMsg = (error?.localizedDescription)!
                
                Utils.sendErrorBackToJavascript(cdvPlugin, cdvCommand: command, errMsg: errMsg)
                cdvPlugin.viewController?.dismiss(animated: true, completion: nil)
                return
            }
            guard let response = purchaseResponse else {
                let failureMsg = (error?.localizedDescription)!
                
                Utils.sendErrorBackToJavascript(cdvPlugin, cdvCommand: command, errMsg: failureMsg)
                cdvPlugin.viewController?.dismiss(animated: true, completion: nil)
                return
            }
            
            //Handling success
            Utils.sendSuccessBackToJavascript(cdvPlugin, cdvCommand: command, successMsg: Utils.getJsonOfPurchaseResponse(response))
            cdvPlugin.viewController?.dismiss(animated: true, completion: nil)
        })
        
        let screenTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        vc.view.addGestureRecognizer(screenTap)
        
        let navController = UINavigationController(rootViewController: vc)
        //addBackNavigationMenuItem(vc)
        
        cdvPlugin.viewController?.present(navController, animated: true, completion: nil)
        currentVc = navController
        isSdkVcShownUsingWindow = false
    }
    

    

  
    
    
    @objc class func dismissKeyboard() {
        currentVc!.view.endEditing(true)
    }
    
    class func addBackNavigationMenuItem(_ currentlyDisplayedVc: UIViewController) {
        let leftButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PayWithUI.backAction))
        
        //currentlyDisplayedVc.navigationItem.title = "Pay"
        currentlyDisplayedVc.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc class func backAction() {
        if(isSdkVcShownUsingWindow) {
            window?.rootViewController = cdvPlugin?.viewController!
            window?.makeKeyAndVisible()
        } else {
            currentVc?.dismiss(animated: true, completion: nil)
        }
    }
}
