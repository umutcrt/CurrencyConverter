//
//  toSettingsVC.swift
//  Converter
//
//  Created by Umut Cörüt on 7.07.2022.
//

import UIKit
import StoreKit

class toSettingsVC: UIViewController, SKPaymentTransactionObserver{
    
    @IBOutlet weak var privacyPolicy: UITextView!
    @IBOutlet weak var termsOfUse: UITextView!
    @IBOutlet weak var subsLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var iapLabel: UIButton!
    @IBOutlet weak var iapLabel2: UIButton!
    @IBOutlet weak var restoreLabel: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString1 = NSMutableAttributedString(string: "Terms of Use")
        let urlTerms = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!
        attributedString1.setAttributes([.link: urlTerms], range: NSMakeRange(0, 12))
        termsOfUse.attributedText = attributedString1
        termsOfUse.isUserInteractionEnabled = true
        termsOfUse.isEditable = false
        termsOfUse.textAlignment = .center
        termsOfUse.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString2 = NSMutableAttributedString(string: "Privacy Policy")
        let urlPrivacy = URL(string: "https://github.com/umutcrt/CurrencyConverter/blob/main/PrivacyPolicy.md")!
        attributedString2.setAttributes([.link: urlPrivacy], range: NSMakeRange(0, 14))
        privacyPolicy.attributedText = attributedString2
        privacyPolicy.isUserInteractionEnabled = true
        privacyPolicy.isEditable = false
        privacyPolicy.textAlignment = .center
        privacyPolicy.linkTextAttributes = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        SKPaymentQueue.default().add(self)
        purchaseStatus = UserDefaults.standard.bool(forKey: "product")
        if purchaseStatus == false {
            confirmLabel.isHidden = true
            subsLabel.isHidden = false
            iapLabel.isHidden = false
            iapLabel2.isHidden = false
            restoreLabel.isHidden = false
        } else {
            confirmLabel.isHidden = false
            subsLabel.isHidden = true
            iapLabel.isHidden = true
            iapLabel2.isHidden = true
            restoreLabel.isHidden = true
        }
        let width = view.frame.size.width
        let height = view.frame.size.height
        iapLabel.titleLabel?.textAlignment = .center
        iapLabel2.titleLabel?.textAlignment = .center
        iapLabel2.frame = CGRect(x: width * 0.05, y: height * 0.60, width: width * 0.40, height: height * 0.20)
        iapLabel.frame = CGRect(x: width * 0.55, y: height * 0.60, width: width * 0.40, height: height * 0.20)
        restoreLabel.frame = CGRect(x: width * 0.325, y: height * 0.85, width: width * 0.35, height: height * 0.04)
        confirmLabel.frame = CGRect(x: width * 0.04, y: height * 0.08, width: width * 0.92, height: height * 0.50)
        design2(label: confirmLabel, corner: 12, border: 0)
        subsLabel.frame = CGRect(x: width * 0.04, y: height * 0.08, width: width * 0.92, height: height * 0.50)
        design2(label: subsLabel, corner: 12, border: 0)
        termsOfUse.frame = CGRect(x: width * 0.04, y: height * 0.85, width: width * 0.24, height: height * 0.04)
        privacyPolicy.frame = CGRect(x: width * 0.72, y: height * 0.85, width: width * 0.24, height: height * 0.04)
        topLabel.frame = CGRect(x: width * 0, y: height * 0, width: width * 1, height: height * 1)
    }
    func design2(label: UILabel, corner: CGFloat, border: CGFloat) {
        label.layer.cornerRadius = corner
        label.layer.masksToBounds = true
        label.layer.borderWidth = border
        label.layer.borderColor = UIColor.lightGray.cgColor
    }
    @IBAction func iapButton(_ sender: Any) {
        buyPremium()
    }
    @IBAction func iap2Button(_ sender: Any) {
        buyPremium2()
    }
    @IBAction func restoreButton(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                let typeOfPurchase: SKPaymentTransaction = transaction
                let prodID = typeOfPurchase.payment.productIdentifier as String
                if prodID == productID {
                    purchasedAfter()
                }
                else if prodID == productID2 {
                    purchasedAfter()
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed dut to error: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .restored {
                let typeOfPurchase: SKPaymentTransaction = transaction
                let prodID = typeOfPurchase.payment.productIdentifier as String
                if prodID == productID {
                    purchasedAfter()
                }
                else if prodID == productID2 {
                    purchasedAfter()
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    func purchasedAfter() {
        UserDefaults.standard.set(true, forKey: "product")
        purchaseStatus = true
        confirmLabel.isHidden = false
        subsLabel.isHidden = true
        iapLabel.isHidden = true
        iapLabel2.isHidden = true
        restoreLabel.isHidden = true
        useCount = 0
    }
    func buyPremium() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {}
    }
    func buyPremium2() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID2
            SKPaymentQueue.default().add(paymentRequest)
        } else {}
    }
}
