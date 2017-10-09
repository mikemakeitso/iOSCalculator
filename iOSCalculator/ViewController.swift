//
//  ViewController.swift
//  iOSCalculator
//
//  Created by Niko Bekic on 2017-09-02.
//  Copyright © 2017 com.mikemakeitso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var calcDisplayLabel: UILabel!  // by adding implict ! for unwrapping. Means all exclamations points can be removed below, no chance are LABEL being nil
    
    // Both ? ans ! Means Optional when decalring variables, and allows set to nil intiall
    // ! exclamation point allows you to remove ! in all displays
    // In Swift all values need to have an initial value
    // Options are intialized specially, they are always set to 'not set' - which means optionals are intialized
    
    private var userIsInTheMiddleOfTyping: Bool = false  // Set Bool to allows initialize to value of class error
    
    
    @IBAction private func touchDigit(_ sender: UIButton){
        
        let digitPressed = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            
            let textCurrentlyInDisplay = calcDisplayLabel.text!
            
            
            // Update Calculator Display Label
            calcDisplayLabel.text = textCurrentlyInDisplay + digitPressed
            
            // Second Label
            //caclUILabel.text = textCurrentlyInDisplay + digit
            
            
            
        }
        else{
            
            // Initialize Calculator Display to blank first time
            calcDisplayLabel.text = digitPressed
            
        }
        
        print("Touched \(digitPressed) digit")
        
        print("Label will display = \(calcDisplayLabel.text!)")
        
        userIsInTheMiddleOfTyping = true
    }
    
    // Calculated Double Value for ALL Double operations
    // Computed value really helps here with reducing code
    private var displayDoubleValue: Double {
        
        get {
            
            // Computed value for Dobule operations
            // Need ! at the nd for unwrapping Double
            return Double(calcDisplayLabel.text!)!
        }
        set {
            //Sets new Duoble Value
            calcDisplayLabel.text = String(newValue)
        }
    }
    
    // var that talks to the model to perform all calculations
    // Every class gets one free intializer
    private var CalcBrain = CalculatorModelBrain()
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            
            CalcBrain.SetOperand(operand: displayDoubleValue)
            
            // Need to reset bool when operands are selected
            userIsInTheMiddleOfTyping = false
            
        }
        
        if let mathematicalSymbol = sender.currentTitle {

            // Call performOperation from Model
            CalcBrain.performOperation(symbol: mathematicalSymbol)
            
        }
        
        // Return Result from Calculator Brain operation
        displayDoubleValue = CalcBrain.result
        
        
        
        //        if let mathematicalSymbol = sender.currentTitle {
        //
        //            if mathematicalSymbol == "π" {
        //
        //                // calcDisplayLabel.text = String(Double.pi)     // M_PI
        //                displayDoubleValue = M_PI
        //
        //
        //            } else if mathematicalSymbol == "√" {
        //
        //                displayDoubleValue = sqrt(displayDoubleValue)
        //            
        //            }
        //            
        //        }
        
        
    }
}

