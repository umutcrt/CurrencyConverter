//
//  currencyClass.swift
//  Converter
//
//  Created by Umut Cörüt on 5.07.2022.
//

import Foundation

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
