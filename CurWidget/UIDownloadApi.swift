//
//  UIDownloadApi.swift
//  currencyWidgetExtension
//
//  Created by Umut Cörüt on 11.08.2022.
//
import Foundation
import SwiftUI
import WidgetKit
import Firebase
import FirebaseFirestore

let db = Firestore.firestore()

func downloadFunc(completion: @escaping ([String : Double]) -> ()) {
    calculateCur()
    
    let docRef = db.collection("rates").document("USD")
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let rates = document.get("rates") as! [String : Double]
            convertWidgetValue(rates: rates)
            completion(rates)
            UserDefaults.standard.setValue(rates, forKey: "ratesOld2")
        } else {
            let rates = UserDefaults.standard.value(forKey: "ratesOld2") as? [String : Double] ?? ratesStandart
            convertWidgetValue(rates: rates)
            completion(rates)
            print("Document does not exist")
        }
    }
}



