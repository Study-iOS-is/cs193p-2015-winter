//
//  CalculatorBrain.swift
//  cs193p-lecture-calculator
//
//  Created by sei on 2023/01/05.
//

import Foundation

class CalcuatorBrain {
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    
    private var operations: [String: Operation] = [
        "𝜋": .Constant(Double.pi),
        "e": .Constant(M_E),
        "√": .UnaryOperation(sqrt),
        "cos": .UnaryOperation(cos),
        "×": .BinaryOperation { $0 * $1 },
        "÷": .BinaryOperation { $0 / $1 },
        "+": .BinaryOperation { $0 + $1 },
        "−": .BinaryOperation { $0 - $1 },
        "=": .UnaryOperation(cos),
    ]
    
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if let pending {
            accumulator = pending.binaryFunction(pending.firstOperand, accumulator)
            self.pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    // read-only property
    var result: Double {
        get {
            return accumulator
        }
    }
    
    
}
