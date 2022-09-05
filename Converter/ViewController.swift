//
//  ViewController.swift
//  Converter
//
//  Created by Umut Cörüt on 15.05.2022.
//

import UIKit
import Network
import StoreKit
import WidgetKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewController: UIViewController {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    var rates = [String : Double]()
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var convertLabel: UIButton!
    @IBOutlet weak var chooseOne: UIButton!
    @IBOutlet weak var chooseTwo: UIButton!
    @IBOutlet weak var chooseThree: UIButton!
    @IBOutlet weak var chooseFour: UIButton!
    @IBOutlet weak var chooseFive: UIButton!
    @IBOutlet weak var chooseSix: UIButton!
    @IBOutlet weak var chooseSeven: UIButton!
    @IBOutlet weak var chooseEight: UIButton!
    @IBOutlet weak var okLabel: UIButton!
    @IBOutlet weak var sectionViewer: UILabel!
    @IBOutlet weak var sectionOne: UIButton!
    @IBOutlet weak var sectionTwo: UIButton!
    @IBOutlet weak var sectionThree: UIButton!
    @IBOutlet weak var sectionFour: UIButton!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var dotLabel: UIButton!
    @IBOutlet weak var imageBackG: UIImageView!
    @IBOutlet weak var equalsLabel: UIButton!
    @IBOutlet weak var divideLabel: UIButton!
    @IBOutlet weak var multiLabel: UIButton!
    @IBOutlet weak var plusLabel: UIButton!
    @IBOutlet weak var minusLabel: UIButton!
    @IBOutlet weak var calculateLabel: UIButton!
    @IBOutlet weak var setSegue: UIButton!
    @IBOutlet weak var connectionText: UILabel!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var widgetView: UILabel!
    @IBOutlet weak var curView1: UILabel!
    @IBOutlet weak var curView2: UILabel!
    @IBOutlet weak var curView3: UILabel!
    @IBOutlet weak var curView4: UILabel!
    @IBOutlet weak var changeButtonLabel: UIButton!
    @IBOutlet weak var unit1Pop: UIButton!
    @IBOutlet weak var unit2Pop: UIButton!
    @IBOutlet weak var num1Label: UIButton!
    @IBOutlet weak var num2Label: UIButton!
    @IBOutlet weak var num3Label: UIButton!
    @IBOutlet weak var num4Label: UIButton!
    @IBOutlet weak var num5Label: UIButton!
    @IBOutlet weak var num6Label: UIButton!
    @IBOutlet weak var num7Label: UIButton!
    @IBOutlet weak var num8Label: UIButton!
    @IBOutlet weak var num9Label: UIButton!
    @IBOutlet weak var num0Label: UIButton!
    @IBOutlet weak var clearLabel: UIButton!
    @IBOutlet weak var delLabel: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        okButtonProcess()
        calculateLabel.isHidden = false
        convertLabel.isHidden = true
        animateControl = true
        viewLabel.text = "0"
        inputLabel.text = "0"
        resultLabel.text = "0"
        //        network control
        if NetworkMonitor.shared.isConnected {
            connectionText.isHidden = true
            downloadCryptos(completion: { rates in
                self.rates = rates
                self.calculateCur()
                UserDefaults.standard.setValue(rates, forKey: "ratesOld")
            })
            format.timeStyle = .short
            format.dateStyle = .short
            updateTime = format.string(from: mytime)
            UserDefaults.standard.setValue(updateTime, forKey: "updateTime")
        } else {
            rates = UserDefaults.standard.value(forKey: "ratesOld") as? [String : Double] ?? ratesStandart
            connectionText.isHidden = false
            calculateCur()
        }
        //        update time
        updateTimeLabel.text! = "Last update: \(UserDefaults.standard.value(forKey: "updateTime") as? String ?? "Data is not available.")"
        //        swipe set
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(fromRightToLeft))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(fromLeftToRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        //        use control
        useCount = UserDefaults.standard.value(forKey: "useCount") as? Int ?? 0
        useCount += 1
        UserDefaults.standard.setValue(useCount, forKey: "useCount")
        //        purchase control
        purchaseStatus = UserDefaults.standard.bool(forKey: "product")
        if purchaseStatus == true {
            setSegue.isHidden = true
        } else {
            if useCount < 5 {
                setSegue.isHidden = true
            } else {
                setSegue.isHidden = false
            }
        }
        //        content placement
        unit1Pop.titleLabel?.textAlignment = .center
        unit2Pop.titleLabel?.textAlignment = .center
        let width = view.frame.size.width
        let height = view.frame.size.height
        sectionViewer.frame = CGRect(x: width * 0.04, y: height * 0.06, width: width * 0.66, height: height * 0.06)
        design(label: sectionViewer, corner: 16, border: 0)
        okLabel.frame = CGRect(x: width * 0.58, y: height * 0.06, width: width * 0.12, height: height * 0.06)
        connectionText.frame = CGRect(x: width * 0.04, y: height * 0.03, width: width * 0.58, height: height * 0.03)
        updateTimeLabel.frame = CGRect(x: width * 0.04, y: height * 0.12, width: width * 0.58, height: height * 0.02)
        chooseOne.frame = CGRect(x: width * 0.04, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseTwo.frame = CGRect(x: width * 0.32, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseThree.frame = CGRect(x: width * 0.04, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseFour.frame = CGRect(x: width * 0.32, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseFive.frame = CGRect(x: width * 0.04, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseSix.frame = CGRect(x: width * 0.32, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseSeven.frame = CGRect(x: width * 0.04, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        chooseEight.frame = CGRect(x: width * 0.32, y: height * 0.065, width: width * 0.24, height: height * 0.05)
        imageBackG.frame = CGRect(x: width * 0, y: height * 0, width: width * 1, height: height * 0.46)
        unit2Pop.frame = CGRect(x: width * 0.04, y: height * 0.25, width: width * 0.22, height: height * 0.06)
        unit1Pop.frame = CGRect(x: width * 0.04, y: height * 0.39, width: width * 0.22, height: height * 0.06)
        inputLabel.frame = CGRect(x: width * 0.28, y: height * 0.37, width: width * 0.68, height: height * 0.08)
        design(label: inputLabel, corner: 24, border: 0)
        resultLabel.frame = CGRect(x: width * 0.28, y: height * 0.25, width: width * 0.68, height: height * 0.08)
        design(label: resultLabel, corner: 24, border: 0)
        viewLabel.frame = CGRect(x: width * 1, y: height * 0.25, width: width * 0.92, height: height * 0.20)
        design(label: viewLabel, corner: 24, border: 0)
        operatorLabel.frame = CGRect(x: width * 1, y: height * 0.26, width: width * 0.04, height: height * 0.04)
        curView1.frame = CGRect(x: width * 0.04, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        sectionOne.frame = CGRect(x: width * 0.04, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        design(label: curView1, corner: 12, border: 0)
        curView2.frame = CGRect(x: width * 0.275, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        sectionTwo.frame = CGRect(x: width * 0.275, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        design(label: curView2, corner: 12, border: 0)
        curView3.frame = CGRect(x: width * 0.51, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        sectionThree.frame = CGRect(x: width * 0.51, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        design(label: curView3, corner: 12, border: 0)
        curView4.frame = CGRect(x: width * 0.745, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        sectionFour.frame = CGRect(x: width * 0.745, y: height * 0.14, width: width * 0.215, height: height * 0.10)
        design(label: curView4, corner: 12, border: 0)
        setButton.frame = CGRect(x: width * 0.84, y: height * 0.06, width: width * 0.12, height: height * 0.06)
        changeButtonLabel.frame = CGRect(x: width * 0.10, y: height * 0.33, width: width * 0.10, height: height * 0.04)
        clearLabel.frame = CGRect(x: width * 0.40, y: height * 0.48, width: width * 0.44, height: height * 0.09)
        num7Label.frame = CGRect(x: width * 0.16, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num8Label.frame = CGRect(x: width * 0.40, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num9Label.frame = CGRect(x: width * 0.64, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num4Label.frame = CGRect(x: width * 0.16, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num5Label.frame = CGRect(x: width * 0.40, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num6Label.frame = CGRect(x: width * 0.64, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num1Label.frame = CGRect(x: width * 0.16, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num2Label.frame = CGRect(x: width * 0.40, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num3Label.frame = CGRect(x: width * 0.64, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num0Label.frame = CGRect(x: width * 0.40, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        calculateLabel.frame = CGRect(x: width * 0.16, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        convertLabel.frame = CGRect(x: width * 0.16, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        delLabel.frame = CGRect(x: width * 0.64, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        dotLabel.frame = CGRect(x: width * 0.16, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        divideLabel.frame = CGRect(x: width * 1, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        multiLabel.frame = CGRect(x: width * 1, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        minusLabel.frame = CGRect(x: width * 1, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        plusLabel.frame = CGRect(x: width * 1, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        equalsLabel.frame = CGRect(x: width * 1, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        widgetView.frame = CGRect(x: width * 0, y: height * 0, width: width * 1, height: height * 0.46)
        setSegue.frame = CGRect(x: width * 0, y: height * 0.46, width: width * 1, height: height * 0.54)
        cur1 = Currency(name: UserDefaults.standard.value(forKey: "cur1") as? String ?? cur1!.name, flag: UserDefaults.standard.value(forKey: "cur1.flag") as? String ?? cur1!.flag)
        cur2 = Currency(name: UserDefaults.standard.value(forKey: "cur2") as? String ?? cur2!.name, flag: UserDefaults.standard.value(forKey: "cur2.flag") as? String ?? cur2!.flag)
        cur3 = Currency(name: UserDefaults.standard.value(forKey: "cur3") as? String ?? cur3!.name, flag: UserDefaults.standard.value(forKey: "cur3.flag") as? String ?? cur3!.flag)
        cur4 = Currency(name: UserDefaults.standard.value(forKey: "cur4") as? String ?? cur4!.name, flag: UserDefaults.standard.value(forKey: "cur4.flag") as? String ?? cur4!.flag)
        cur5 = Currency(name: UserDefaults.standard.value(forKey: "cur5") as? String ?? cur5!.name, flag: UserDefaults.standard.value(forKey: "cur5.flag") as? String ?? cur5!.flag)
        cur6 = Currency(name: UserDefaults.standard.value(forKey: "cur6") as? String ?? cur6!.name, flag: UserDefaults.standard.value(forKey: "cur6.flag") as? String ?? cur6!.flag)
        cur7 = Currency(name: UserDefaults.standard.value(forKey: "cur7") as? String ?? cur7!.name, flag: UserDefaults.standard.value(forKey: "cur7.flag") as? String ?? cur7!.flag)
        cur8 = Currency(name: UserDefaults.standard.value(forKey: "cur8") as? String ?? cur8!.name, flag: UserDefaults.standard.value(forKey: "cur8.flag") as? String ?? cur8!.flag)
        PopUpButton1()
        PopUpButton2()
        PopUpButton3()
        PopUpButton4()
        PopUpButton5()
        PopUpButton6()
        PopUpButton7()
        PopUpButton8()
    }
    func animateView() {
        let width = view.frame.size.width
        let height = view.frame.size.height
        operatorLabel.frame = CGRect(x: width * 1, y: height * 0.26, width: width * 0.04, height: height * 0.04)
        unit2Pop.frame = CGRect(x: width * 0.04, y: height * 0.25, width: width * 0.22, height: height * 0.06)
        unit1Pop.frame = CGRect(x: width * 0.04, y: height * 0.39, width: width * 0.22, height: height * 0.06)
        inputLabel.frame = CGRect(x: width * 0.28, y: height * 0.37, width: width * 0.68, height: height * 0.08)
        resultLabel.frame = CGRect(x: width * 0.28, y: height * 0.25, width: width * 0.68, height: height * 0.08)
        divideLabel.frame = CGRect(x: width * 1, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        multiLabel.frame = CGRect(x: width * 1, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        minusLabel.frame = CGRect(x: width * 1, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        plusLabel.frame = CGRect(x: width * 1, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        equalsLabel.frame = CGRect(x: width * 1, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        viewLabel.frame = CGRect(x: width * 1, y: height * 0.25, width: width * 0.92, height: height * 0.20)
        changeButtonLabel.frame = CGRect(x: width * 0.10, y: height * 0.33, width: width * 0.10, height: height * 0.04)
        clearLabel.frame = CGRect(x: width * 0.40, y: height * 0.48, width: width * 0.44, height: height * 0.09)
        num7Label.frame = CGRect(x: width * 0.16, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num8Label.frame = CGRect(x: width * 0.40, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num9Label.frame = CGRect(x: width * 0.64, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num4Label.frame = CGRect(x: width * 0.16, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num5Label.frame = CGRect(x: width * 0.40, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num6Label.frame = CGRect(x: width * 0.64, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num1Label.frame = CGRect(x: width * 0.16, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num2Label.frame = CGRect(x: width * 0.40, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num3Label.frame = CGRect(x: width * 0.64, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num0Label.frame = CGRect(x: width * 0.40, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        calculateLabel.frame = CGRect(x: width * 0.16, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        convertLabel.frame = CGRect(x: width * 0.16, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        delLabel.frame = CGRect(x: width * 0.64, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        dotLabel.frame = CGRect(x: width * 0.16, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        animater()
        func animater() {
            UIView.animate(withDuration: 0.5, animations: {
                self.operatorLabel.frame = CGRect(x: width * 0.90, y: height * 0.26, width: width * 0.04, height: height * 0.04)
                self.unit2Pop.frame = CGRect(x: width * -1, y: height * 0.25, width: width * 0.22, height: height * 0.06)
                self.unit1Pop.frame = CGRect(x: width * -1, y: height * 0.39, width: width * 0.22, height: height * 0.06)
                self.inputLabel.frame = CGRect(x: width * -1, y: height * 0.37, width: width * 0.68, height: height * 0.08)
                self.resultLabel.frame = CGRect(x: width * -1, y: height * 0.25, width: width * 0.68, height: height * 0.08)
                self.viewLabel.frame = CGRect(x: width * 0.04, y: height * 0.25, width: width * 0.92, height: height * 0.20)
                self.divideLabel.frame = CGRect(x: width * 0.76, y: height * 0.48, width: width * 0.20, height: height * 0.09)
                self.multiLabel.frame = CGRect(x: width * 0.76, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.minusLabel.frame = CGRect(x: width * 0.76, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.plusLabel.frame = CGRect(x: width * 0.76, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.equalsLabel.frame = CGRect(x: width * 0.76, y: height * 0.88, width: width * 0.20, height: height * 0.09)
                self.changeButtonLabel.frame = CGRect(x: width * -1, y: height * 0.33, width: width * 0.10, height: height * 0.04)
                self.clearLabel.frame = CGRect(x: width * 0.28, y: height * 0.48, width: width * 0.44, height: height * 0.09)
                self.num7Label.frame = CGRect(x: width * 0.04, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.num8Label.frame = CGRect(x: width * 0.28, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.num9Label.frame = CGRect(x: width * 0.52, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.num4Label.frame = CGRect(x: width * 0.04, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.num5Label.frame = CGRect(x: width * 0.28, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.num6Label.frame = CGRect(x: width * 0.52, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.num1Label.frame = CGRect(x: width * 0.04, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.num2Label.frame = CGRect(x: width * 0.28, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.num3Label.frame = CGRect(x: width * 0.52, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.num0Label.frame = CGRect(x: width * 0.28, y: height * 0.88, width: width * 0.20, height: height * 0.09)
                self.calculateLabel.frame = CGRect(x: width * 0.04, y: height * 0.48, width: width * 0.20, height: height * 0.09)
                self.convertLabel.frame = CGRect(x: width * 0.04, y: height * 0.48, width: width * 0.20, height: height * 0.09)
                self.delLabel.frame = CGRect(x: width * 0.52, y: height * 0.88, width: width * 0.20, height: height * 0.09)
                self.dotLabel.frame = CGRect(x: width * 0.04, y: height * 0.88, width: width * 0.20, height: height * 0.09)
            }, completion: { done in
                if done {
                }
            })
        }
    }
    func animateView2() {
        let width = view.frame.size.width
        let height = view.frame.size.height
        operatorLabel.frame = CGRect(x: width * 0.90, y: height * 0.26, width: width * 0.04, height: height * 0.04)
        unit2Pop.frame = CGRect(x: width * -1, y: height * 0.25, width: width * 0.22, height: height * 0.06)
        unit1Pop.frame = CGRect(x: width * -1, y: height * 0.39, width: width * 0.22, height: height * 0.06)
        inputLabel.frame = CGRect(x: width * -1, y: height * 0.37, width: width * 0.68, height: height * 0.08)
        resultLabel.frame = CGRect(x: width * -1, y: height * 0.25, width: width * 0.68, height: height * 0.08)
        divideLabel.frame = CGRect(x: width * 0.76, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        multiLabel.frame = CGRect(x: width * 0.76, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        minusLabel.frame = CGRect(x: width * 0.76, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        plusLabel.frame = CGRect(x: width * 0.76, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        equalsLabel.frame = CGRect(x: width * 0.76, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        viewLabel.frame = CGRect(x: width * 0.04, y: height * 0.25, width: width * 0.92, height: height * 0.20)
        changeButtonLabel.frame = CGRect(x: width * -1, y: height * 0.33, width: width * 0.10, height: height * 0.04)
        clearLabel.frame = CGRect(x: width * 0.28, y: height * 0.48, width: width * 0.44, height: height * 0.09)
        num7Label.frame = CGRect(x: width * 0.04, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num8Label.frame = CGRect(x: width * 0.28, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num9Label.frame = CGRect(x: width * 0.52, y: height * 0.58, width: width * 0.20, height: height * 0.09)
        num4Label.frame = CGRect(x: width * 0.04, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num5Label.frame = CGRect(x: width * 0.28, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num6Label.frame = CGRect(x: width * 0.52, y: height * 0.68, width: width * 0.20, height: height * 0.09)
        num1Label.frame = CGRect(x: width * 0.04, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num2Label.frame = CGRect(x: width * 0.28, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num3Label.frame = CGRect(x: width * 0.52, y: height * 0.78, width: width * 0.20, height: height * 0.09)
        num0Label.frame = CGRect(x: width * 0.28, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        calculateLabel.frame = CGRect(x: width * 0.04, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        convertLabel.frame = CGRect(x: width * 0.04, y: height * 0.48, width: width * 0.20, height: height * 0.09)
        delLabel.frame = CGRect(x: width * 0.52, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        dotLabel.frame = CGRect(x: width * 0.04, y: height * 0.88, width: width * 0.20, height: height * 0.09)
        animater()
        func animater() {
            UIView.animate(withDuration: 0.5, animations: {
                self.operatorLabel.frame = CGRect(x: width * 1, y: height * 0.26, width: width * 0.04, height: height * 0.04)
                self.unit2Pop.frame = CGRect(x: width * 0.04, y: height * 0.25, width: width * 0.22, height: height * 0.06)
                self.unit1Pop.frame = CGRect(x: width * 0.04, y: height * 0.39, width: width * 0.22, height: height * 0.06)
                self.inputLabel.frame = CGRect(x: width * 0.28, y: height * 0.37, width: width * 0.68, height: height * 0.08)
                self.resultLabel.frame = CGRect(x: width * 0.28, y: height * 0.25, width: width * 0.68, height: height * 0.08)
                self.viewLabel.frame = CGRect(x: width * 1, y: height * 0.25, width: width * 0.92, height: height * 0.20)
                self.divideLabel.frame = CGRect(x: width * 1, y: height * 0.48, width: width * 0.20, height: height * 0.09)
                self.multiLabel.frame = CGRect(x: width * 1, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.minusLabel.frame = CGRect(x: width * 1, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.plusLabel.frame = CGRect(x: width * 1, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.equalsLabel.frame = CGRect(x: width * 1, y: height * 0.88, width: width * 0.20, height: height * 0.09)
                self.changeButtonLabel.frame = CGRect(x: width * 0.10, y: height * 0.33, width: width * 0.10, height: height * 0.04)
                self.clearLabel.frame = CGRect(x: width * 0.40, y: height * 0.48, width: width * 0.44, height: height * 0.09)
                self.num7Label.frame = CGRect(x: width * 0.16, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.num8Label.frame = CGRect(x: width * 0.40, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.num9Label.frame = CGRect(x: width * 0.64, y: height * 0.58, width: width * 0.20, height: height * 0.09)
                self.num4Label.frame = CGRect(x: width * 0.16, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.num5Label.frame = CGRect(x: width * 0.40, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.num6Label.frame = CGRect(x: width * 0.64, y: height * 0.68, width: width * 0.20, height: height * 0.09)
                self.num1Label.frame = CGRect(x: width * 0.16, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.num2Label.frame = CGRect(x: width * 0.40, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.num3Label.frame = CGRect(x: width * 0.64, y: height * 0.78, width: width * 0.20, height: height * 0.09)
                self.num0Label.frame = CGRect(x: width * 0.40, y: height * 0.88, width: width * 0.20, height: height * 0.09)
                self.calculateLabel.frame = CGRect(x: width * 0.16, y: height * 0.48, width: width * 0.20, height: height * 0.09)
                self.convertLabel.frame = CGRect(x: width * 0.16, y: height * 0.48, width: width * 0.20, height: height * 0.09)
                self.delLabel.frame = CGRect(x: width * 0.64, y: height * 0.88, width: width * 0.20, height: height * 0.09)
                self.dotLabel.frame = CGRect(x: width * 0.16, y: height * 0.88, width: width * 0.20, height: height * 0.09)
            }, completion: { done in
                if done {
                }
            })
        }
    }
    func design(label: UILabel, corner: CGFloat, border: CGFloat) {
        label.layer.cornerRadius = corner
        label.layer.masksToBounds = true
        label.layer.borderWidth = border
    }
    
    //    Button process
    @IBAction func setSegueButton(_ sender: Any) {
        purchaseStatus = UserDefaults.standard.bool(forKey: "product")
        if purchaseStatus == true {
            setSegue.isHidden = true
        } else {
            performSegue(withIdentifier: "toPurchaseVC", sender: nil)
        }
    }
    @IBAction func fromRightToLeft() {
        if animateControl == true {
            animateView()
            animateControl = false
            convertLabel.isHidden = false
            calculateLabel.isHidden = true
            okButtonProcess()
        }
    }
    @IBAction func fromLeftToRight() {
        if animateControl == false {
            animateView2()
            animateControl = true
            convertLabel.isHidden = true
            calculateLabel.isHidden = false
            okButtonProcess()
        }
    }
    @IBAction func num1(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 1)
        } else {
            numSelect(num: 1)
        }
        okButtonProcess()
    }
    @IBAction func num2(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 2)
        } else {
            numSelect(num: 2)
        }
        okButtonProcess()
    }
    @IBAction func num3(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 3)
        } else {
            numSelect(num: 3)
        }
        okButtonProcess()
    }
    @IBAction func num4(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 4)
        } else {
            numSelect(num: 4)
        }
        okButtonProcess()
    }
    @IBAction func num5(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 5)
        } else {
            numSelect(num: 5)
        }
        okButtonProcess()
    }
    @IBAction func num6(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 6)
        } else {
            numSelect(num: 6)
        }
        okButtonProcess()
    }
    @IBAction func num7(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 7)
        } else {
            numSelect(num: 7)
        }
        okButtonProcess()
    }
    @IBAction func num8(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 8)
        } else {
            numSelect(num: 8)
        }
        okButtonProcess()
    }
    @IBAction func num9(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 9)
        } else {
            numSelect(num: 9)
        }
        okButtonProcess()
    }
    @IBAction func num0(_ sender: Any) {
        if animateControl == false {
            numberSelect(num2: 0)
        } else {
            numSelect(num: 0)
        }
        okButtonProcess()
    }
    @IBAction func clearButton(_ sender: Any) {
        if animateControl == false {
            viewLabel.text = "0"
            operatorLabel.text = ""
            answer = ""
            stockAnswer = ""
            processControl = false
        } else {
            inputLabel.text! = "0"
            resultLabel.text! = "0.000"
            convertValue()
        }
        okButtonProcess()
    }
    @IBAction func delButton(_ sender: Any) {
        if animateControl == false {
            if viewLabel.text == "Error" {
            } else {
                if processControl == false {
                    if viewLabel.text != "" {
                        viewLabel.text!.removeLast()
                        if viewLabel.text == "" {
                            viewLabel.text = "0"
                        }
                    } else {}
                }
            }
        } else {
            if inputLabel.text != "" {
                inputLabel.text!.removeLast()
                convertValue()
            } else {
                convertValue()
            }
        }
        okButtonProcess()
    }
    @IBAction func dotButton(_ sender: Any) {
        if animateControl == false {
            if viewLabel.text == "Error" {
            } else {
                if operatorLabel.text! != "=" {
                    if viewLabel.text!.count < 9 {
                        if viewLabel.text!.contains(".") {
                        } else {
                            viewLabel.text! += "."
                        }
                    }
                } else {}
            }
        } else {
            if inputLabel.text!.contains(".") {
            } else {
                inputLabel.text! += "."
            }
        }
        okButtonProcess()
    }
    @IBAction func sectionOneButton(_ sender: Any) {
        sectionViewer.isHidden = false
        okLabel.isHidden = false
        chooseOne.isHidden = false
        chooseTwo.isHidden = false
        chooseThree.isHidden = true
        chooseFour.isHidden = true
        chooseFive.isHidden = true
        chooseSix.isHidden = true
        chooseSeven.isHidden = true
        chooseEight.isHidden = true
    }
    @IBAction func sectionTwoButton(_ sender: Any) {
        sectionViewer.isHidden = false
        okLabel.isHidden = false
        chooseOne.isHidden = true
        chooseTwo.isHidden = true
        chooseThree.isHidden = false
        chooseFour.isHidden = false
        chooseFive.isHidden = true
        chooseSix.isHidden = true
        chooseSeven.isHidden = true
        chooseEight.isHidden = true
    }
    @IBAction func sectionThreeButton(_ sender: Any) {
        sectionViewer.isHidden = false
        okLabel.isHidden = false
        chooseOne.isHidden = true
        chooseTwo.isHidden = true
        chooseThree.isHidden = true
        chooseFour.isHidden = true
        chooseFive.isHidden = false
        chooseSix.isHidden = false
        chooseSeven.isHidden = true
        chooseEight.isHidden = true
    }
    @IBAction func sectionFourButton(_ sender: Any) {
        sectionViewer.isHidden = false
        okLabel.isHidden = false
        chooseOne.isHidden = true
        chooseTwo.isHidden = true
        chooseThree.isHidden = true
        chooseFour.isHidden = true
        chooseFive.isHidden = true
        chooseSix.isHidden = true
        chooseSeven.isHidden = false
        chooseEight.isHidden = false
    }
    @IBAction func okButton(_ sender: Any) {
        okButtonProcess()
    }
    @IBAction func convertButton(_ sender: Any) {
        animateView2()
        animateControl = true
        convertLabel.isHidden = true
        calculateLabel.isHidden = false
        okButtonProcess()
    }
    @IBAction func calculateButton(_ sender: Any) {
        animateView()
        animateControl = false
        convertLabel.isHidden = false
        calculateLabel.isHidden = true
        okButtonProcess()
    }
    @IBAction func changeButton(_ sender: Any) {
        let valueChange = currency1
        currency1 = currency2
        currency2 = valueChange
        setPopUpButton1()
        setPopUpButton2()
        convertValue()
        UserDefaults.standard.setValue(currency1?.name, forKey: "currency1")
        UserDefaults.standard.setValue(currency1?.flag, forKey: "currency1.flag")
        UserDefaults.standard.setValue(currency2?.name, forKey: "currency2")
        UserDefaults.standard.setValue(currency2?.flag, forKey: "currency2.flag")
        okButtonProcess()
    }
    @IBAction func plusButton(_ sender: Any) {
        calculateProcess(opr: "+")
        okButtonProcess()
    }
    @IBAction func minusButton(_ sender: Any) {
        calculateProcess(opr: "-")
        okButtonProcess()
    }
    @IBAction func multiButton(_ sender: Any) {
        calculateProcess(opr: "x")
        okButtonProcess()
    }
    @IBAction func divideButton(_ sender: Any) {
        calculateProcess(opr: "/")
        okButtonProcess()
    }
    @IBAction func equalsButton(_ sender: Any) {
        if stockAnswer != "" && processControl == false {
            calculateProcess(opr: "=")
        } else {}
        okButtonProcess()
    }
    //    process functions
    func okButtonProcess() {
        sectionViewer.isHidden = true
        okLabel.isHidden = true
        chooseOne.isHidden = true
        chooseTwo.isHidden = true
        chooseThree.isHidden = true
        chooseFour.isHidden = true
        chooseFive.isHidden = true
        chooseSix.isHidden = true
        chooseSeven.isHidden = true
        chooseEight.isHidden = true
    }
    func numSelect(num: Int) {
        if animateControl == true {
            if inputLabel.text!.count < 12 {
                if inputLabel.text! != "0" {
                    inputLabel.text! += "\(num)"
                    convertValue()
                } else {
                    inputLabel.text! = ""
                    inputLabel.text! += "\(num)"
                    convertValue()
                }
            } else {}
        } else {}
    }
    func numberSelect(num2: Int) {
        if viewLabel.text == "Error" || operatorLabel.text! == "=" {
        } else {
            if processControl == true {
                viewLabel.text = "0"
                processControl = false
            } else {}
            if viewLabel.text!.count < 9 && operatorLabel.text! != "=" {
                if viewLabel.text! != "0" {
                    viewLabel.text! += "\(num2)"
                } else {
                    viewLabel.text! = ""
                    viewLabel.text! += "\(num2)"
                }
            } else {}
        }
    }
    func calculateCur() {
        currency1 = Currency(name: UserDefaults.standard.value(forKey: "currency1") as? String ?? currency1!.name, flag: UserDefaults.standard.value(forKey: "currency1.flag") as? String ?? currency1!.flag)
        currency2 = Currency(name: UserDefaults.standard.value(forKey: "currency2") as? String ?? currency2!.name, flag: UserDefaults.standard.value(forKey: "currency2.flag") as? String ?? currency2!.flag)
        cur1 = Currency(name: UserDefaults.standard.value(forKey: "cur1") as? String ?? cur1!.name, flag: UserDefaults.standard.value(forKey: "cur1.flag") as? String ?? cur1!.flag)
        cur2 = Currency(name: UserDefaults.standard.value(forKey: "cur2") as? String ?? cur2!.name, flag: UserDefaults.standard.value(forKey: "cur2.flag") as? String ?? cur2!.flag)
        cur3 = Currency(name: UserDefaults.standard.value(forKey: "cur3") as? String ?? cur3!.name, flag: UserDefaults.standard.value(forKey: "cur3.flag") as? String ?? cur3!.flag)
        cur4 = Currency(name: UserDefaults.standard.value(forKey: "cur4") as? String ?? cur4!.name, flag: UserDefaults.standard.value(forKey: "cur4.flag") as? String ?? cur4!.flag)
        cur5 = Currency(name: UserDefaults.standard.value(forKey: "cur5") as? String ?? cur5!.name, flag: UserDefaults.standard.value(forKey: "cur5.flag") as? String ?? cur5!.flag)
        cur6 = Currency(name: UserDefaults.standard.value(forKey: "cur6") as? String ?? cur6!.name, flag: UserDefaults.standard.value(forKey: "cur6.flag") as? String ?? cur6!.flag)
        cur7 = Currency(name: UserDefaults.standard.value(forKey: "cur7") as? String ?? cur7!.name, flag: UserDefaults.standard.value(forKey: "cur7.flag") as? String ?? cur7!.flag)
        cur8 = Currency(name: UserDefaults.standard.value(forKey: "cur8") as? String ?? cur8!.name, flag: UserDefaults.standard.value(forKey: "cur8.flag") as? String ?? cur8!.flag)
        self.setPopUpButton1()
        self.setPopUpButton2()
        self.convertValue()
        self.convertWidgetValue()
    }
    func convertValue() {
        ratesOne = rates[currency1!.name]!
        ratesTwo = rates[currency2!.name]!
        ratesTotals = (ratesTwo / ratesOne)
        if inputLabel.text! != "" {
            let outputValue = Double(inputLabel.text!)! * ratesTotals
            rslt = "\(String(format: "%.3f", outputValue))"
            for _ in 1...3 {
                if rslt.hasSuffix("0") {
                    rslt.removeLast()
                    if rslt.hasSuffix(".") {
                        rslt.removeLast()
                    }
                }
            }
            resultLabel.text! = rslt
        } else {
            inputLabel.text! = "0"
            let outputValue = Double(inputLabel.text!)! * ratesTotals
            rslt = "\(String(format: "%.3f", outputValue))"
            for _ in 1...3 {
                if rslt.hasSuffix("0") {
                    rslt.removeLast()
                    if rslt.hasSuffix(".") {
                        rslt.removeLast()
                    }
                }
            }
            resultLabel.text! = rslt
        }
    }
    func convertWidgetValue() {
        rates1 = rates[cur1!.name]!
        rates2 = rates[cur2!.name]!
        ratesTotals1 = (rates2 / rates1)
        curView1.text = "\(cur1!.flag) / \(cur2!.flag)\n⊙\n\(String(format: "%.4f", ratesTotals1))"
        rates3 = rates[cur3!.name]!
        rates4 = rates[cur4!.name]!
        ratesTotals2 = (rates4 / rates3)
        curView2.text = "\(cur3!.flag) / \(cur4!.flag)\n⊙\n\(String(format: "%.4f", ratesTotals2))"
        rates5 = rates[cur5!.name]!
        rates6 = rates[cur6!.name]!
        ratesTotals3 = (rates6 / rates5)
        curView3.text = "\(cur5!.flag) / \(cur6!.flag)\n⊙\n\(String(format: "%.4f", ratesTotals3))"
        rates7 = rates[cur7!.name]!
        rates8 = rates[cur8!.name]!
        ratesTotals4 = (rates8 / rates7)
        curView4.text = "\(cur7!.flag) / \(cur8!.flag)\n⊙\n\(String(format: "%.4f", ratesTotals4))"
    }
    func calculateProcess(opr: String) {
        if viewLabel.text == "Error" {
        } else {
            if processControl == false {
                if stockAnswer == "" {
                    if viewLabel.text != "0" {
                        if viewLabel.text!.hasSuffix(".") {
                            viewLabel.text!.removeLast()
                        } else {}
                        operatorLabel.text = opr
                        stockAnswer = viewLabel.text!
                        processControl = true
                    } else {}
                } else {
                    if viewLabel.text!.hasSuffix(".") {
                        viewLabel.text!.removeLast()
                    } else {}
                    let expn1 = NSExpression(format: stockAnswer)
                    let expn3 = NSExpression(format: viewLabel.text!)
                    stockAnswer = "\(expn1.expressionValue(with: nil, context: nil) as! Double)"
                    viewLabel.text! = "\(expn3.expressionValue(with: nil, context: nil) as! Double)"
                    answer = "\(stockAnswer)\(operatorLabel.text!)\(viewLabel.text!)"
                    answer = answer.replacingOccurrences(of: "x", with: "*")
                    let expn = NSExpression(format: answer)
                    var rslt = expn.expressionValue(with: nil, context: nil) as! Double
                    var longrslt = "\(String(format: "%.3f", rslt))"
                    for _ in 1...3 {
                        if longrslt.hasSuffix("0") {
                            longrslt.removeLast()
                            if longrslt.hasSuffix(".") {
                                longrslt.removeLast()
                            }
                        }
                    }
                    if longrslt.count > 18 {
                        viewLabel.text = "Error"
                    } else {
                        viewLabel.text! = longrslt
                    }
                    stockAnswer = viewLabel.text!
                    operatorLabel.text = opr
                    processControl = true
                    rslt = 0
                    longrslt = ""
                }
            } else {
                operatorLabel.text = opr
            }
        }
    }
    
    //    popUpButtons functions
    func setPopUpButton1(){
        let optionClosure = {(action : UIAction) in
            currency1 = currencyList.first { $0.visibleName() == action.title }
            self.okButtonProcess()
            UserDefaults.standard.setValue(currency1?.name, forKey: "currency1")
            UserDefaults.standard.setValue(currency1?.flag, forKey: "currency1.flag")
            self.convertValue()
        }
        unit1Pop.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == currency1?.name ? .on : .off, handler: optionClosure) } )
        unit1Pop.showsMenuAsPrimaryAction = true
        unit1Pop.changesSelectionAsPrimaryAction = true
    }
    func setPopUpButton2(){
        let optionClosure = {(action : UIAction) in
            currency2 = currencyList.first { $0.visibleName() == action.title }
            self.okButtonProcess()
            UserDefaults.standard.setValue(currency2?.name, forKey: "currency2")
            UserDefaults.standard.setValue(currency2?.flag, forKey: "currency2.flag")
            self.convertValue()
        }
        unit2Pop.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == currency2?.name ? .on : .off, handler: optionClosure) } )
        unit2Pop.showsMenuAsPrimaryAction = true
        unit2Pop.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton1(){
        let optionClosure = {(action : UIAction) in
            cur1 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur1?.name, forKey: "cur1")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur1?.name, forKey: "Scur1")
            }
            UserDefaults.standard.setValue(cur1?.flag, forKey: "cur1.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur1?.flag, forKey: "Scur1.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseOne.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur1?.name ? .on : .off, handler: optionClosure) } )
        chooseOne.showsMenuAsPrimaryAction = true
        chooseOne.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton2(){
        let optionClosure = {(action : UIAction) in
            cur2 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur2?.name, forKey: "cur2")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur2?.name, forKey: "Scur2")
            }
            UserDefaults.standard.setValue(cur2?.flag, forKey: "cur2.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur2?.flag, forKey: "Scur2.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseTwo.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur2?.name ? .on : .off, handler: optionClosure) } )
        chooseTwo.showsMenuAsPrimaryAction = true
        chooseTwo.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton3(){
        let optionClosure = {(action : UIAction) in
            cur3 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur3?.name, forKey: "cur3")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur3?.name, forKey: "Scur3")
            }
            UserDefaults.standard.setValue(cur3?.flag, forKey: "cur3.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur3?.flag, forKey: "Scur3.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseThree.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur3?.name ? .on : .off, handler: optionClosure) } )
        chooseThree.showsMenuAsPrimaryAction = true
        chooseThree.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton4(){
        let optionClosure = {(action : UIAction) in
            cur4 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur4?.name, forKey: "cur4")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur4?.name, forKey: "Scur4")
            }
            UserDefaults.standard.setValue(cur4?.flag, forKey: "cur4.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur4?.flag, forKey: "Scur4.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseFour.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur4?.name ? .on : .off, handler: optionClosure) } )
        chooseFour.showsMenuAsPrimaryAction = true
        chooseFour.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton5(){
        let optionClosure = {(action : UIAction) in
            cur5 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur5?.name, forKey: "cur5")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur5?.name, forKey: "Scur5")
            }
            UserDefaults.standard.setValue(cur5?.flag, forKey: "cur5.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur5?.flag, forKey: "Scur5.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseFive.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur5?.name ? .on : .off, handler: optionClosure) } )
        chooseFive.showsMenuAsPrimaryAction = true
        chooseFive.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton6(){
        let optionClosure = {(action : UIAction) in
            cur6 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur6?.name, forKey: "cur6")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur6?.name, forKey: "Scur6")
            }
            UserDefaults.standard.setValue(cur6?.flag, forKey: "cur6.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur6?.flag, forKey: "Scur6.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseSix.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur6?.name ? .on : .off, handler: optionClosure) } )
        chooseSix.showsMenuAsPrimaryAction = true
        chooseSix.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton7(){
        let optionClosure = {(action : UIAction) in
            cur7 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur7?.name, forKey: "cur7")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur7?.name, forKey: "Scur7")
            }
            UserDefaults.standard.setValue(cur7?.flag, forKey: "cur7.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur7?.flag, forKey: "Scur7.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseSeven.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur7?.name ? .on : .off, handler: optionClosure) } )
        chooseSeven.showsMenuAsPrimaryAction = true
        chooseSeven.changesSelectionAsPrimaryAction = true
    }
    func PopUpButton8(){
        let optionClosure = {(action : UIAction) in
            cur8 = currencyList.first { $0.visibleName() == action.title }
            self.convertWidgetValue()
            UserDefaults.standard.setValue(cur8?.name, forKey: "cur8")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur8?.name, forKey: "Scur8")
            }
            UserDefaults.standard.setValue(cur8?.flag, forKey: "cur8.flag")
            if let userDefaults = UserDefaults(suiteName: "group.com.cur.app.identifier") {
                userDefaults.setValue(cur8?.flag, forKey: "Scur8.flag")
            }
            WidgetCenter.shared.reloadTimelines(ofKind: "CurWidget")
        }
        chooseEight.menu = UIMenu (children: currencyList.map { UIAction(title: $0.visibleName(), state: $0.name == cur8?.name ? .on : .off, handler: optionClosure) } )
        chooseEight.showsMenuAsPrimaryAction = true
        chooseEight.changesSelectionAsPrimaryAction = true
    }
}
