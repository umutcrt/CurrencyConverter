//
//  functions.swift
//  Converter
//
//  Created by Umut Cörüt on 15.05.2022.
//

import Foundation
import UIKit

func downloadCryptos() {
    var semaphore = DispatchSemaphore (value: 0)
    
    let url = "https://api.apilayer.com/exchangerates_data/latest?symbols=AUD%2CUSD%2CCAD%2CCHF%2CJPY%2CNZD%2CEUR%2CGBP%2CSGD%2CCZK%2CRUB%2CTRY%2CCNH&base=USD"
    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    request.addValue("raK9kCIHdYEpSiV9IDPqKZFJGVol8UQq", forHTTPHeaderField: "apikey")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
            
            if let rates = jsonResponse["rates"] as? [String : Double] {
                rates1 = rates["\(currency1)"]!
                rates2 = rates["\(currency2)"]!
               
            }
            ratesTotals = (rates2 / rates1)
            print("\(ratesTotals)")
            semaphore.signal()
        } catch {
            print("error")
        }
    }
    
    task.resume()
    semaphore.wait()
}
