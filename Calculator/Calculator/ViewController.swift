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
        switch sender.currentTitle! {
        case "+": performOperation({ $0 + $1 })
        case "−": performOperation({ $1 - $0 })
        case "×": performOperation({ $0 * $1 })
        case "÷": performOperation({ $1 / $0 })
        default: break;
        }
    }
    
    func performOperation(operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

    var operandStack = Array<Double>()
    @IBAction func enter() {
        operandStack.append(displayValue)
        userInTyping = false
        println("\(operandStack)")
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

