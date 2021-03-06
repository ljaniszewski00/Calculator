//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Łukasz Janiszewski on 10/07/2021.
//

import Foundation

struct CalculatorModel {
    private(set) var a = ""
    private(set) var customOperator = ""
    private(set) var b = ""
    private(set) var equalitySign = "="
    private(set) var result = "0"
    
    public mutating func chooseButton(buttonText: String) {
        if [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].contains(Int(buttonText)) {
            self.assignFunctionToSimpleNumericButton(number: buttonText)
        } else {
            self.assignFunctionToCustomOperator(operatorSign: buttonText)
        }
    }
    
    public mutating func assignFunctionToSimpleNumericButton(number: String) {
        if number == "0" {
            if !a.isEmpty && customOperator.isEmpty {
                a += "\(number)"
            } else if !b.isEmpty && !customOperator.isEmpty {
                b += "\(number)"
            }
        } else {
            if customOperator.isEmpty {
                a += "\(number)"
            } else if !customOperator.isEmpty {
                b += "\(number)"
            }
        }
    }
    
    public mutating func assignFunctionToCustomOperator(operatorSign: String) {
        switch operatorSign {
        case divisionSign:
            if !a.isEmpty {
                customOperator = divisionSign
            }
        case multiplicationSign:
            if !a.isEmpty {
                customOperator = multiplicationSign
            }
        case additionSign:
            if a == subtractionSign || a.isEmpty {
                a = ""
            } else if !a.isEmpty {
                customOperator = additionSign
            }
            if !customOperator.isEmpty {
                if b == subtractionSign || b.isEmpty {
                    b = ""
                }
            }
        case subtractionSign:
            if a.isEmpty && !a.contains(subtractionSign) {
                a = subtractionSign
            } else if !customOperator.isEmpty {
                if b.isEmpty && !b.contains(subtractionSign) {
                    b = subtractionSign
                } else {
                    customOperator = subtractionSign
                }
            } else if !a.isEmpty {
                customOperator = subtractionSign
            }
        case oppositeSign:
            if !a.isEmpty {
                if customOperator.isEmpty {
                    a = removeSuffix(data: String(-Double(a)!))
                } else {
                    if !b.isEmpty {
                        b = removeSuffix(data: String(-Double(b)!))
                    }
                }
            }
        case percentSign:
            if !a.isEmpty {
                if customOperator.isEmpty {
                    a = removeSuffix(data: String(Double(a)! * 100))
                } else {
                    if !b.isEmpty {
                        b = removeSuffix(data: String(Double(b)! * 100))
                    }
                }
            }
        case clearSign:
            a = ""
            customOperator = ""
            b = ""
            equalitySign = "="
            result = "0"
        case "↑":
            if !result.isEmpty && result != "0" {
                a = result
                customOperator = ""
                b = ""
                equalitySign = "="
                result = "0"
            }
        case ".":
            if customOperator.isEmpty && !a.contains(".") {
                a += "."
            } else if !customOperator.isEmpty && !b.contains(".") {
                b += "."
            }
        case "=":
            switch customOperator {
            case divisionSign:
                if !b.isEmpty {
                    if !(b == "0") && !(b == "-0") {
                        result = removeSuffix(data: String(Double(a)! / Double(b)!))
                    }
                }
            case multiplicationSign:
                if !b.isEmpty {
                    result = removeSuffix(data: String(Double(a)! * Double(b)!))
                }
            case subtractionSign:
                if !b.isEmpty {
                    result = removeSuffix(data: String(Double(a)! - Double(b)!))
                }
            case additionSign:
                if !b.isEmpty {
                    result = removeSuffix(data: String(Double(a)! + Double(b)!))
                }
            default:
                result = "0"
            }
        default:
            result = "0"
        }
    }
    
    private func removeSuffix(data: String) -> String {
        if data.hasSuffix(".0") {
            return String(data.dropLast(2))
        } else {
            return data
        }
    }
}
