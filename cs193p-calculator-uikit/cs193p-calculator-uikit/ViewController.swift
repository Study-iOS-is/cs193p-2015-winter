//
//  ViewController.swift
//  cs193p-calculator-uikit
//
//  Created by sei_dev on 1/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var display: UILabel!
    
    private var userIsInTheMiddleOfTyping: Bool = false
    private var resultContainsDot: Bool = false
    
    private var displayValue: Double {
        get {
            return Double(display.text ?? "0") ?? 0
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        if let textCurrentInDisplay = display.text,
           let pressedDigit = sender.titleLabel?.text {
            switch pressedDigit {
            case ".":
                if false == resultContainsDot {
                    display.text = textCurrentInDisplay + pressedDigit
                    resultContainsDot = true
                    userIsInTheMiddleOfTyping = true
                }
            default:
                if userIsInTheMiddleOfTyping {
                    display.text = textCurrentInDisplay + pressedDigit
                } else {
                    display.text = pressedDigit
                    userIsInTheMiddleOfTyping = true
                }
            }
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.titleLabel {
            brain.performOperation(symbol: mathematicalSymbol)
        }
    }
    
}

