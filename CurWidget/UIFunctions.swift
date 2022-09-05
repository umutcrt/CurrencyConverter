//
//  UIFunctions.swift
//  currencyWidgetExtension
//
//  Created by Umut Cörüt on 11.08.2022.
//
import Foundation
import SwiftUI


func convertWidgetValue(rates: [String : Double]) {
    rates1 = rates[cur1!.name]!
    rates2 = rates[cur2!.name]!
    ratesTotals1 = (rates2 / rates1)
    rates3 = rates[cur3!.name]!
    rates4 = rates[cur4!.name]!
    ratesTotals2 = (rates4 / rates3)
    rates5 = rates[cur5!.name]!
    rates6 = rates[cur6!.name]!
    ratesTotals3 = (rates6 / rates5)
    rates7 = rates[cur7!.name]!
    rates8 = rates[cur8!.name]!
    ratesTotals4 = (rates8 / rates7)
    
    curView1 = "\(cur1!.flag) ⇾ \(cur2!.flag)"
    curView12 = "\(String(format: "%.4f", ratesTotals1))"

    curView2 = "\(cur3!.flag) ⇾ \(cur4!.flag)"
    curView22 = "\(String(format: "%.4f", ratesTotals2))"

    curView3 = "\(cur5!.flag) ⇾ \(cur6!.flag)"
    curView32 = "\(String(format: "%.4f", ratesTotals3))"

    curView4 = "\(cur7!.flag) ⇾ \(cur8!.flag)"
    curView42 = "\(String(format: "%.4f", ratesTotals4))"
}

func calculateCur() {
    cur1 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur1") ?? cur1!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur1.flag") ?? cur1!.flag)
    cur2 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur2") ?? cur2!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur2.flag") ?? cur2!.flag)
    cur3 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur3") ?? cur3!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur3.flag") ?? cur3!.flag)
    cur4 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur4") ?? cur4!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur4.flag") ?? cur4!.flag)
    cur5 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur5") ?? cur5!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur5.flag") ?? cur5!.flag)
    cur6 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur6") ?? cur6!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur6.flag") ?? cur6!.flag)
    cur7 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur7") ?? cur7!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur7.flag") ?? cur7!.flag)
    cur8 = Currency(name: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur8") ?? cur8!.name, flag: UserDefaults(suiteName: "group.com.cur.app.identifier")!.string(forKey: "Scur8.flag") ?? cur8!.flag)
}
