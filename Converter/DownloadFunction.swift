//
//  functions.swift
//  Converter
//
//  Created by Umut Cörüt on 15.05.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

var db = Firestore.firestore()

func downloadCryptos(completion: @escaping ([String : Double]) -> ()) {
    
    let docRef = db.collection("rates").document("USD")
    docRef.getDocument(source: .default) { (document, error) in
      if let document = document {
          let rates = document.get("rates") as! [String : Double]
          completion(rates)
      }
    }
}
