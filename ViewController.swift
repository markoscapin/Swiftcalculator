//
//  ViewController.swift
//  mycalculator
//
//  Created by Marco Scapin on 25/04/2020.
//  Copyright © 2020 Marco Scapin. All rights reserved.
//

import UIKit
extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
    
class ViewController: UIViewController {
    
    
    var oprtracker = 0
    var num1 = ""
    var num2 = ""
    var result = "0"
    var oprtodo = ""
    let valorePerImprobabilita:Float = 0.0000000000000000000000000000001
    var equalPressed = 0
    
    @IBOutlet weak var resultBar: UILabel!
    
    @IBOutlet weak var resetNum_acButton: UIButton!
    

    
    
    override func viewDidLoad() {
           resultBar.text = "0"
       }
    
    //all numbers buttons
    @IBAction func numButtons(_ sender: UIButton) {
    //if num 1
        if oprtracker == 0 {
            if equalPressed == 1 {
                num1 = ""
                num1Result(num: sender.accessibilityLabel!)
                resultBar.text = num1
                switcherAcToC(num: num1, label: resetNum_acButton.accessibilityLabel!)
                equalPressed = 0
            } else {
                num1Result(num: sender.accessibilityLabel!)
                resultBar.text = num1
                switcherAcToC(num: num1, label: resetNum_acButton.accessibilityLabel!)
                equalPressed = 0
            }
            
            
    // if num 2
        } else if oprtracker == 1 {
            num2Result(num: sender.accessibilityLabel!)
            resultBar.text = num2
            print("Sto Scrivendo su Num2 : \(num2)")

        }
    }
    
    //WHAT TO DO IF PRESSED? -> REGISTER DATA AS OPRTODO FOR MATHOPERATIONS
    @IBAction func oprButtons(_ sender: UIButton) {
        oprToDoAndTypeModeSwitcher(opr: sender.accessibilityLabel!)
        print(sender.accessibilityLabel!)
        
        
        // da fare qualche check con oprtracker perché sennò risulta sempre oprtracker 1        !!!
        if oprtracker == 0 {
                num2 = ""
                oprtracker = 1
                print("Questo è l'attuale tracker : \(oprtracker)")


        } else if num1 == result {
            oprtracker = 1
            
        }
}
    
    

     // EQUAL BUTTON OK! ANCHE RIPETIZIONE CON NUM1 = RESULT E NUM2 COME NELLA CALCOLATRICE VERA
    @IBAction func equalButton(_ sender: UIButton) {
        mathoperations(firstNum: num1, operatorMatcher: oprtodo, secondNum: num2)
        resultBar.text = result
        num1 = result
        oprtracker = 0
        equalPressed = 1
        print("num1 = \(num1)")
        print("num2 = \(num2)")
        print("oprtracker = \(oprtracker)")
        
        
        
    }
    
    
    
    
    // COMPLETATO CHANGE FACE BUTTONS, FUNZIONANTI SIA NEL CASO ORIG SIA INT O FLOAT NELLA STRINGA
    @IBAction func changeFaceButtons(_ sender: UIButton) {
        //IN CASE NUM1
        if oprtracker == 0 {
            if sender.accessibilityLabel! == "+/-" {
                if num1 == "" {
                    resultBar.text = "0"
                } else {
                    let temporaryFloat:Float = Float(num1) ?? valorePerImprobabilita
                    if temporaryFloat > 0 {
                        num1 = "-" + num1
                        resultBar.text = num1           // lo faccio visualizz display
                    } else if temporaryFloat < 0 {
                        let maybeInt = Int(num1) ?? nil
                        if maybeInt != nil {
                            num1 = String(maybeInt! - (maybeInt! - maybeInt!))
                            resultBar.text = num1       // lo faccio visualizz display
                        } else {
                            num1 = String(temporaryFloat - (temporaryFloat - temporaryFloat))
                            resultBar.text = num1
                        }
                        
                    }
                }
        // % button
            } else {
                if num1 == "" {
                    resultBar.text = "0"
                } else {
                    let temporaryVar: Float = Float(num1) ?? valorePerImprobabilita
                    num1 = String(temporaryVar / 100)
                    resultBar.text = num1
                }
            }
            
            

            
            
            
            
        //IN CASE NUM2
        } else {
            if sender.accessibilityLabel! == "+/-" {
                let temporaryFloat:Float = Float(num2) ?? valorePerImprobabilita
                if temporaryFloat > 0 && temporaryFloat != valorePerImprobabilita  {
                    num2 = "-" + num2
                    resultBar.text = num2
                } else if temporaryFloat < 0 && temporaryFloat != valorePerImprobabilita {
                    let maybeInt = Int(num2) ?? nil
                    if maybeInt != nil {
                        num2 = String(maybeInt! - (maybeInt! - maybeInt!))
                        resultBar.text = num2
                    } else {
                        num2 = String(temporaryFloat - (temporaryFloat - temporaryFloat))
                        resultBar.text = num2
                    }
                }else if temporaryFloat == valorePerImprobabilita {
                    resultBar.text = "0"
                }
        // % button
            } else {
                let temporaryVar: Float = Float(num2) ?? valorePerImprobabilita
                print("Questo è il temporaryVar \(temporaryVar)")
                if temporaryVar == valorePerImprobabilita {
                    resultBar.text = "0"
                    num2 = ""
                    print("Non è passato e il valore è perfetto!")
                } else {
                num2 = String(temporaryVar / 100)
                resultBar.text = num2
                print("Questo invece è passato e quindi va su num2 : \(num2)")
                }
            }
        }
    }
    
    //RESETTA TUTTI GLI STATUS NUM1 E NUM2 INSIEME A RESULTBAR CHE INIZIALIZZA OPRTRACKER
    //IMPLEMENTATA LA FUNZIONE PER CUI SE CLICCHI SU AC IN FASE "C" RITORNA IN "AC" E SE LO RIPREMI ALLORA VA A RESETTARE                   OK PERFETTA
    @IBAction func resetStatusBarAC(_ sender: UIButton) {
        
    // HERE THE SWITHER BETWEEN AC BUTTON AND C BUTTON
//        switcherAcToC (num: String, label: String)
        
        // questo serve per far si che num 1 o num 2 venga resettato diciamo
        if resetNum_acButton.accessibilityLabel == "C" {
            if oprtracker == 0 {
                num1 = ""
                resultBar.text = "0"
                switcherAcToC(num: num1, label: resetNum_acButton.accessibilityLabel! )
            } else if oprtracker == 1 {
                num2 = "0"
                resultBar.text = num2
            }

        }
    //here IS AC BUTTON
        if resetNum_acButton.accessibilityLabel == "AC" {
            resultBar.text = "0"
            oprtracker = 0
            num1 = ""
            num2 = ""
            result = "0"
            oprtodo = ""
            print("num1 = \(num1), num2 = \(num2), opr = \(oprtodo), oprtraker = \(oprtracker), result = \(result)")
            
        }
    }
    
    //FUNZIONE SWITCHER OK!!!!
    func switcherAcToC (num: String, label: String) {
        print(label)
        print(num)
        if label == "AC" && num != "" {
            resetNum_acButton.accessibilityLabel = "C"
            resetNum_acButton.setTitle("C", for: [])
            print("primo")
        } else if label == "C" && num == "" {
            resetNum_acButton.accessibilityLabel = "AC"
            resetNum_acButton.setTitle("AC", for: [])
            print("secondo")
        }
    }
    
    
    
    
    // MATH OPERATOR (operatorMarcher)
    func oprToDoAndTypeModeSwitcher(opr: String ) {
        oprtodo = opr
    }
    
    //identifier for 1 line on calc
    func num1Result(num : String) {
        if num1 == "0" || num1 == "" {
            if num == "." {
                num1 = "0."
            } else {
                num1 = num
            }
        } else {
            num1 = num1 + num
        }
    }
   // identifier for 2 line on calc
    func num2Result(num : String) {
        if num2 == "0" || num2 == "" {
            if num == "." {
                num2 = "0."
            } else {
                num2 = num
            }
        } else {
            num2 = num2 + num
        }
    }
    
    
    //ALL MATH OPERATIONS GOES TO RESULT
    //DA FARE CHECK CON FUNC INT OR FLOAT POICHè MI FA PRINT NIL POICHè INIZIO CON FNUM FLOAT   !!!!!!
    func mathoperations(firstNum: String , operatorMatcher: String, secondNum: String) {
        let fNum: Float = Float(firstNum) ?? 0
        let fNum2: Float = Float(secondNum) ?? 0
        
        //CASE OF NUM2 = ""
        if secondNum == "" {
            mathoperations(firstNum: firstNum, operatorMatcher: operatorMatcher, secondNum: firstNum)
            print(result)
        //NORMAL CASE
        } else {
            let add = fNum + fNum2
            let meno = fNum - fNum2
            let multiple = fNum * fNum2
            let divide = fNum / fNum2
            
    
            if operatorMatcher == "+" {
                intOrFloat(ipoteticNum: String(add))
            } else if operatorMatcher == "-" {
                intOrFloat(ipoteticNum: String(meno))
            } else if operatorMatcher == "x" {
                intOrFloat(ipoteticNum: String(multiple))
            } else if operatorMatcher == "/" {
                intOrFloat(ipoteticNum: String(divide))
            }
            print(result)
        }
    }
    // SERVE PER DARE A RESULT UN RISULTATO INT O FLOAT NELLA STRINGA - BETTER VIEW
    func intOrFloat (ipoteticNum: String) {
            let temporaryFloatIpo:Float = Float(ipoteticNum) ?? 0
                result = String(temporaryFloatIpo.clean)
    }
    

}

