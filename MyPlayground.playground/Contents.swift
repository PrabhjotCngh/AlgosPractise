import UIKit

/*
 Write a function:

 public func solution(_ A : inout [Int]) -> Int

 that, given an array A of N integers, returns the smallest positive integer (greater than 0) that does not occur in A.

 For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.

 Given A = [1, 2, 3], the function should return 4.

 Given A = [−1, −3], the function should return 1.

 Write an efficient algorithm for the following assumptions:

 N is an integer within the range [1..100,000];
 each element of array A is an integer within the range [−1,000,000..1,000,000].
 */

public func solution(_ A : [Int]) -> Int {
    let positive = A.filter { $0 > 0 }.sorted()
    var x = 1
    for val in positive {
      // if we find a smaller number no need to continue, cause the array is sorted
      if(x < val) {
       return x
      }
       x = val + 1
    }
  return x
}

print(solution([2,5,6,8,9,10]))

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

