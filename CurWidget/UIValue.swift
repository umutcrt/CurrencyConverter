//
//  UIValue.swift
//  currencyWidgetExtension
//
//  Created by Umut Cörüt on 11.08.2022.
//
import Foundation
import SwiftUI


public class Currency {
    var name: String
    var flag: String
    func visibleName() -> String {
        return "\(self.name) \(self.flag)"
    }
    init(name: String, flag: String) {
        self.name = name
        self.flag = flag
    }
}

var cur1 = currencyList.first { $0.name == "EUR" }
var cur2 = currencyList.first { $0.name == "USD" }
var cur3 = currencyList.first { $0.name == "GBP" }
var cur4 = currencyList.first { $0.name == "USD" }
var cur5 = currencyList.first { $0.name == "CNY" }
var cur6 = currencyList.first { $0.name == "USD" }
var cur7 = currencyList.first { $0.name == "BTC" }
var cur8 = currencyList.first { $0.name == "USD" }

var curView1 = "\(cur1!.flag) ⇾ \(cur2!.flag)"
var curView12 = "\(String(format: "%.4f", ratesTotals1))"

var curView2 = "\(cur3!.flag) ⇾ \(cur4!.flag)"
var curView22 = "\(String(format: "%.4f", ratesTotals2))"

var curView3 = "\(cur5!.flag) ⇾ \(cur6!.flag)"
var curView32 = "\(String(format: "%.4f", ratesTotals3))"

var curView4 = "\(cur7!.flag) ⇾ \(cur8!.flag)"
var curView42 = "\(String(format: "%.4f", ratesTotals4))"


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
var updateTime = ""
var mytime = Date()
var format = DateFormatter()
//var rates = [String : Double]()

