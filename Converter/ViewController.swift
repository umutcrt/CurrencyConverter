//
//  ViewController.swift
//  Converter
//
//  Created by Umut Cörüt on 15.05.2022.
//

import UIKit

var currency1 = "TRY"
var currency2 = "TRY"
var ratesTotals: Double  = 0.0
var rates1: Double  = 0.0
var rates2: Double  = 0.0

class ViewController: UIViewController {
    
    @IBOutlet weak var unit1Pop: UIButton!
    @IBOutlet weak var unit2Pop: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    func setPopUpButton1(){
        let optionClosure = {(action : UIAction) in
            currency1 = action.title
            print(action.title)
            downloadCryptos()
        }
        unit1Pop.menu = UIMenu (children: [
            UIAction(title: "TRY", state: .on, handler: optionClosure),
            UIAction(title: "USD", state: .on, handler: optionClosure),
            UIAction(title: "AUD", state: .on, handler: optionClosure),
            UIAction(title: "CAD", state: .on, handler: optionClosure),
            UIAction(title: "JPY", state: .on, handler: optionClosure),
            UIAction(title: "NZD", state: .on, handler: optionClosure),
            UIAction(title: "EUR", state: .on, handler: optionClosure),
            UIAction(title: "GBP", state: .on, handler: optionClosure),
            UIAction(title: "CZK", state: .on, handler: optionClosure),
            UIAction(title: "RUB", state: .on, handler: optionClosure)
        ] )
        unit1Pop.showsMenuAsPrimaryAction = true
        unit1Pop.changesSelectionAsPrimaryAction = true
    }
    func setPopUpButton2(){
        let optionClosure = {(action : UIAction) in
            currency2 = action.title
            print(action.title)
            downloadCryptos()
        }
        unit2Pop.menu = UIMenu (children: [
            UIAction(title: "TRY", state: .on, handler: optionClosure),
            UIAction(title: "USD", state: .on, handler: optionClosure),
            UIAction(title: "AUD", state: .on, handler: optionClosure),
            UIAction(title: "CAD", state: .on, handler: optionClosure),
            UIAction(title: "JPY", state: .on, handler: optionClosure),
            UIAction(title: "NZD", state: .on, handler: optionClosure),
            UIAction(title: "EUR", state: .on, handler: optionClosure),
            UIAction(title: "GBP", state: .on, handler: optionClosure),
            UIAction(title: "CZK", state: .on, handler: optionClosure),
            UIAction(title: "RUB", state: .on, handler: optionClosure)
        ] )
        unit2Pop.showsMenuAsPrimaryAction = true
        unit2Pop.changesSelectionAsPrimaryAction = true
    }
    @IBAction func convert(_ sender: Any) {
        
        if inputLabel.text! != "" {
            resultLabel.text = "\(Double(inputLabel.text!)! * ratesTotals)"
        } else {
            inputLabel.text! = "1"
            resultLabel.text = "\(Double(inputLabel.text!)! * ratesTotals)"
        }
    }
    @IBOutlet weak var inputLabel: UILabel!
    @IBAction func num1(_ sender: Any) {
        inputLabel.text! += "1"
    }
    @IBAction func num2(_ sender: Any) {
        inputLabel.text! += "2"
    }
    @IBAction func num3(_ sender: Any) {
        inputLabel.text! += "3"
    }
    @IBAction func num4(_ sender: Any) {
        inputLabel.text! += "4"
    }
    @IBAction func num5(_ sender: Any) {
        inputLabel.text! += "5"
    }
    @IBAction func num6(_ sender: Any) {
        inputLabel.text! += "6"
    }
    @IBAction func num7(_ sender: Any) {
        inputLabel.text! += "7"
    }
    @IBAction func num8(_ sender: Any) {
        inputLabel.text! += "8"
    }
    @IBAction func num9(_ sender: Any) {
        inputLabel.text! += "9"
    }
    @IBAction func num0(_ sender: Any) {
        inputLabel.text! += "0"
    }
    @IBAction func clearButton(_ sender: Any) {
        inputLabel.text! = ""
        resultLabel.text! = ""
    }
    @IBAction func delButton(_ sender: Any) {
        if inputLabel.text != "" {
            inputLabel.text!.removeLast()
        } else {}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        downloadCryptos()
        setPopUpButton1()
        setPopUpButton2()
    }
}

