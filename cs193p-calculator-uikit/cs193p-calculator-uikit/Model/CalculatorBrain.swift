//
//  CalculatorBrain.swift
//  cs193p-calculator-uikit
//
//  Created by sei_dev on 1/5/23.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    var operations: Dictionary<String, Operations> = [
        "𝝿": .constants(Double.pi)
    ]
    
    enum Operations {
        case constants(Double)
        case unaryOperation((Double)->(Double))
        case binaryOperation((Double, Double) -> (Double))
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }

    //    func performOperation(symbol: Operations) {
    func performOperation(symbol: String) -> Double {
        if let operation = operations[symbol] {
            switch operation {
            case .constants(let x):
                return x
            default:
                return 0.0
            }
        }
    }
    
}
