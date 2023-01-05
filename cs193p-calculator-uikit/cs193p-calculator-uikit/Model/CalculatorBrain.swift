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
    
    private var operations: Dictionary<String, Operations> = [
        "𝝿": .constants(Double.pi),
        "𝖢": .Clear,
        "√": .unaryOperation(sqrt),
        "÷": .binaryOperation { $0 / $1 },
        "×": .binaryOperation { $0 * $1 },
        "−": .binaryOperation { $0 - $1 },
        "+": .binaryOperation { $0 + $1 },
        "=": .Equals
    ]
    
    private enum Operations {
        case constants(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private struct CalculatorInfo {
        var prevOperand: Double
        var prevOperation: (Double, Double) -> Double
    }
    
    private var info: CalculatorInfo?

    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constants(let x):
                accumulator = x
            case .unaryOperation(let function):
                let result = function(accumulator)
                print(result, symbol, function, function(10))
                accumulator = result
            case .binaryOperation(let function):
                performPrevOperation()
                info = CalculatorInfo(prevOperand: accumulator, prevOperation: function)
                accumulator = 0.0
            case .Equals:
                performPrevOperation()
            case .Clear:
                accumulator = 0.0
            }
        }
    }
    
    private func performPrevOperation() {
        if let info {
            accumulator = info.prevOperation(info.prevOperand, accumulator)
            self.info = nil
        }
    }
}
