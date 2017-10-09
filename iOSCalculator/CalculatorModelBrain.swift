//
//  CalculatorModelBrain.swift
//  iOSCalculator
//
//  Created by Niko Bekic on 2017-09-04.
//  Copyright © 2017 com.mikemakeitso. All rights reserved.
//

import Foundation  //For Models, never import UIKit


//        enum Optional<T>{
//
//              case None
//              case Some (T)
//
//        }

// Wanted to make this a Global function - not part of the below class
func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

func divide(op1: Double, op2: Double) -> Double {
    return op1 / op2
}

func add(op1: Double, op2: Double) -> Double {
    return op1 + op2
}

func substract(op1: Double, op2: Double) -> Double {
    return op1 - op2
}

func plusminus(op1: Double) -> Double {
    return -1 * (op1)
}

class CalculatorModelBrain {
    
    // Acculates the results to pass back to View
    // 0.0 makes Swuft infer accumulator to a Double
    private var accumulator = 0.0
    
    func SetOperand(operand: Double) {
        
        accumulator = operand
        
    }
    
    // Dictionary table lookup for ALL Operations
    // Dictionary is a Swift thing
    // [] intializes Dictionary
    var operations: Dictionary<String, enumOperation> = [
    
        "π" : enumOperation.Constant( M_PI),                // M_PI
        "℮" : enumOperation.Constant( M_E),                 // M_E
        "√" : enumOperation.UnaryOperation( sqrt),
        "cos" : enumOperation.UnaryOperation( cos),             // cos
        "×" : enumOperation.BinaryOperation( multiply),         // Multiply Function will handle times
        "÷" : enumOperation.BinaryOperation( divide),       // Multiply Function will handle times
        "+" : enumOperation.BinaryOperation( add),         // Multiply Function will handle times
        "-" : enumOperation.BinaryOperation( substract),         // Multiply Function will handle times
        "=" : enumOperation.Equals,                         //
        "±" : enumOperation.UnaryOperation( plusminus),     // Reverse Sign
        "AC" : enumOperation.Clear                           //
    ]
    
    // enum Operations - Discrete set of values
    // enums can have methods like classes
    // No storage vars, No inheritance,
    enum enumOperation {
        case Constant( Double)                               // for constants like M_PI
        case UnaryOperation(( Double) -> Double)             // Function is the Associated value for UnaryOperation
        case BinaryOperation(( Double, Double) -> Double)    //
        case Equals
        case Clear
    }
    

    
    // Variable for pending information, Optional and will initialize to nil
    private var pendingOperations: PendingBinaryOperationInfo? //Optional struct
    
    
    // struct pass byValue
    // similar to class, but no inheritance
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }


    // Performs Calculator Operation
    func performOperation(symbol: String) {
        
        
        // Operations looks up in dictionary
        if let operation = operations[symbol] {
            
            // switch only has to take care of number of cases in the enum
            switch operation {
            
            case .Constant(let associatedConstantValue): accumulator = associatedConstantValue   // Works for constants only like M_PI and M_E
            
            case .UnaryOperation(let function): accumulator = function(accumulator) // for sqrt function() that takes a double and returns a double is the asscotiated value
                
            case .BinaryOperation(let function): pendingOperations = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator) //For multiply, divide, add, substract
            
            case .Equals:
                if pendingOperations != nil {
                    
                    //
                    accumulator = pendingOperations!.binaryFunction(pendingOperations!.firstOperand, accumulator)
                    
                    // reset pending indicator after equlas operation completed
                    pendingOperations = nil
                }
            
            case .Clear:
                // reset pending indicator after equlas operation completed
                pendingOperations = nil
                accumulator = 0.0
            }
            
        
//        if let constant = operations[symbol]{
//            
//            accumulator = constant
//            
//        }
        
//        switch symbol {
//            
//        case "π": accumulator = Double.pi
//        case "√": accumulator = sqrt(accumulator)
//            
//            
//        default: break
//            
        }
        else {
                // ignores other unknown symbols
        }
    }
    
    
    var result: Double {
        
        // Make result READ ONLY property since there is not SET
        get{
            return accumulator
        }
    }
    
}
