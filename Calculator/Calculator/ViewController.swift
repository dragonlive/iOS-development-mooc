//
//  ViewController.swift
//  Calculator
//
//  Created by Longsheng Wang on 4/19/15.
//  Copyright (c) 2015 Longsheng Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var userInTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userInTyping){
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userInTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        appendToHistory(sender.currentTitle!)
        switch sender.currentTitle! {
        case "+": performOperation({ $0 + $1 })
        case "−": performOperation({ $1 - $0 })
        case "×": performOperation({ $0 * $1 })
        case "÷": performOperation({ $1 / $0 })
        case "√": performOperation { sqrt($0)}
        case "π": performOperation { $0 * M_PI}
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        case "c": history.text = ""; operandStack.removeAll(); display.text="0"; break;
        default: break;
        }
    }
    @IBAction func appendDot() {
        if display.text?.rangeOfString(".") == nil {
            display.text = display.text! + "."
        }
        userInTyping = true
    }
    
    func performOperation(operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    var operandStack = Array<Double>()
    @IBAction func enter() {
        operandStack.append(displayValue)
        userInTyping = false
        appendToHistory(displayValue)
        println("\(operandStack)")
    }
    
    func appendToHistory<T>(content: T){
        if history.text != nil && !history.text!.isEmpty {
            history.text = history.text!  + "\r\n" + "\(content)"
        }
        else {
            history.text = "\(content)"
        }
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userInTyping = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

