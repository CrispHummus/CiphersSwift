//
//  Crypt.swift
//  crypt
//
//  Created by Tristan Branković on 6/8/18.
//  Copyright © 2018 parab3llum. All rights reserved.
//

import Foundation

let alphaToMorse = ["A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".", "F": "..-.", "G": "--.", "H": "....", "I": "..", "J": ".---", "K": "-.-", "L": ".-..", "M": "--", "N": "-.", "O": "---", "P": ".--.", "Q": "--.-", "R": ".-.", "S": "...", "T": "-", "U": "..-", "V": "...-", "W": ".--", "X": "-..-", "Y": "-.--", "Z": "--..", "1": ".----", "2": "..---", "3": "...--", "4": "....-", "5": ".....", "6": "-....", "7": "--...", "8": "---..", "9": "----.", "0": "-----"]
let morseToAlpha = [".-": "A", "-...": "B", "-.-.": "C", "-..": "D", ".": "E", "..-.": "F", "--.": "G", "....": "H", "..": "I", ".---": "J", "-.-": "K", ".-..": "L", "--": "M", "-.": "N", "---": "O", ".--.": "P", "--.-": "Q", ".-.": "R", "...": "S", "-": "T", "..-": "U", "...-": "V", ".--": "W", "-..-": "X", "-.--": "Y", "--..": "Z", ".----": "1", "..---": "2", "...--": "3", "....-": "4", ".....": "5", "-....": "6", "--...": "7", "---..": "8", "----.": "9", "-----": "0"]

public class Encrypt {
    
    private init() {}
    
    static public func caesarCipher(str: String, shift: Int) -> String {
        var charArr = [Character]()
        
        //read each character in string
        for char in str.unicodeScalars {
            var charCode = Int(char.value)
            
            //determine if not a character below 63 = not letters
            if char.value > 63 {
                charCode += abs(shift) % 26

                if char.value < 91 {
                    //letter is uppercase
                    charCode = charCode > 90 ? (charCode - 26) : charCode
                } else if char.value < 123 {
                    //letter is lowercase
                    charCode = charCode > 121 ? (charCode - 26) : charCode
                }
            }
            //recreate array of encrypted characters
            charArr.append(Character(UnicodeScalar(charCode)!))
        }
        return String(charArr)
    }
    
    static public func rot1(str: String) -> String {
        return caesarCipher(str: str, shift: 1)
    }
    
    static public func rot13(str: String) -> String {
        return caesarCipher(str: str, shift: 13)
    }
    
    static public func base64(str: String) -> String {
        return (str.data(using: .utf8)?.base64EncodedString())!
    }
    
    static public func morse(str: String) -> String {
        var morseStr = String()
        
        for char in str.uppercased().unicodeScalars {
            let charCode = Int(char.value)
           
            if charCode > 64 && charCode < 91 {
                morseStr += alphaToMorse[String(UnicodeScalar(charCode)!)]! + " "
            } else if char == " " {
                morseStr += "/ "
            }
        }
        return morseStr
    }
}

public class Decrypt {
    
    private init() {}
    
    static public func caesarCipher(str: String) -> String {
        var returnStr = String()
        
        for i in 1...25 {
            returnStr += Encrypt.caesarCipher(str: str, shift: i) + "\n"
        }
        return Encrypt.caesarCipher(str: str, shift: 0)
    }
    
    static public func rot1(str: String) -> String {
        return Encrypt.caesarCipher(str: str, shift: 25)
    }
   
    static public func rot13(str: String) -> String {
        return Encrypt.caesarCipher(str: str, shift: 13)
    }
    
    static public func base64(str: String) -> String {
        return String(data: Data(base64Encoded: str)!, encoding: .utf8)!
    }
    
    static public func morse(str: String) -> String {
        let morseWords = str.components(separatedBy: "/")
        var returnStr = String()
        
        for morseWord in morseWords {
            let morseChars = morseWord.components(separatedBy: " ")

            for morseChar in morseChars {
                //remove any unrecognizable characters
                var cleanMC = String()
                for c in morseChar {
                    if c == "." || c == "-" {
                        cleanMC += String(c)
                    }
                }
                
                let char = morseToAlpha[cleanMC]
                
                //check if in morse alphabet
                if char != nil {
                    returnStr += char!
                } else {
                    if char != "" && char != nil {
                        returnStr += "?"
                    }
                }
            }
            //add space between words
            returnStr += " "
        }
        return returnStr
    }
}
