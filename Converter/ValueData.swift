//
//  ValueData.swift
//  Currency Converter
//
//  Created by Umut Cörüt on 6.08.2022.
//

import Foundation

//ViewController
var currency1 = currencyList.first { $0.name == "USD" }
var currency2 = currencyList.first { $0.name == "EUR" }
var cur1 = currencyList.first { $0.name == "EUR" }
var cur2 = currencyList.first { $0.name == "USD" }
var cur3 = currencyList.first { $0.name == "GBP" }
var cur4 = currencyList.first { $0.name == "USD" }
var cur5 = currencyList.first { $0.name == "CNY" }
var cur6 = currencyList.first { $0.name == "USD" }
var cur7 = currencyList.first { $0.name == "BTC" }
var cur8 = currencyList.first { $0.name == "USD" }
var ratesTotals1: Double  = 0.0
var ratesTotals2: Double  = 0.0
var ratesTotals3: Double  = 0.0
var ratesTotals4: Double  = 0.0
var ratesTotals: Double  = 0.0
var ratesOne: Double  = 0.0
var ratesTwo: Double  = 0.0
var rates1: Double  = 0.0
var rates2: Double  = 0.0
var rates3: Double  = 0.0
var rates4: Double  = 0.0
var rates5: Double  = 0.0
var rates6: Double  = 0.0
var rates7: Double  = 0.0
var rates8: Double  = 0.0
var useCount = 0
var rslt = ""
var answer = ""
var stockAnswer = ""
var updateTime = ""
var animateControl = true
var processControl = false
let mytime = Date()
let format = DateFormatter()
//toSettingsVC
let productID = "com.umutcorut.currencyConverterUseApp"
let productID2 = "com.umutcorut.currencyConverterUseAppMonthly"
var purchaseStatus = false
