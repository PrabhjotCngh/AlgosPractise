import UIKit

/*
 Please write a piece of code that returns a substring of a given string with a known index. We don’t want to have truncated words in the returned string, so if the index is pointing to a character inside a word, we want the whole word to be included in the result.
 
 example:
 Given String: “I believe that people are really good at heart”
 Index: 5
 Result: “I believe”

 Index 200
 Result: “I believe that people are really good at heart”

 Index: -1
 Result: nil or null
 */

func subStringOfGivenString(index: Int, inputString: String) -> String? {
    ///Handled first edge case if index is less than 0
    if index < 0 {
        return nil
    }
    
    ///Handled second edge case if index is less than inputString length than only continue
    guard index < inputString.count else {
        return inputString
    }
    
    ///Declare constants and variables
    let inputStringArr = Array(inputString)
    var charArray = [Character]()
    var isIndexMatched = false
    
    ///Iterate over the string array to find the substring
    for i in 0..<inputStringArr.count {
        if i == index {
            charArray.append(inputStringArr[i])
            isIndexMatched = true
        } else {
            if isIndexMatched {
                if inputStringArr[i] == " " {
                    break
                }
            }
            charArray.append(inputStringArr[i])
        }
    }
    
    ///Return final string
    return String(charArray)
}

print(subStringOfGivenString(index: 20, inputString: "I believe that people are really good at heart") ?? "nil")
