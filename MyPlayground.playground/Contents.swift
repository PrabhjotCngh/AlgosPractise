import UIKit
import Foundation

/*
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.

[-2,1,-3,4,-1,2,1,-5,4]
[-2,1,-2,4,3,5,6,1,5]

max(4-1, -1)

*/

func sumOfLargestObjectsInArray(arr: [Int]) -> Int {
    var maxSoFar = Int.min
    var sum = 0
    
    for num in arr {
      sum = max(num, num+sum)
      maxSoFar = max(maxSoFar, sum)
    }

    return maxSoFar
}

print(sumOfLargestObjectsInArray(arr: [-2,1,-3,4,-1,2,1,-5,4]))

func countTopicOccurrences(topics: [String: [String]], reviews: [String]) -> [String: Int] {
    // TODO: COMPLETE ME
    var topicOccurrences = [String: Int]()
    var totalOccurrences = 0
    for (key, value) in topics {
        for keywordsItem in value {
            totalOccurrences = 0
            for reviewsItem in reviews {
                if reviewsItem.contains(keywordsItem) || reviewsItem.contains(keywordsItem.capitalized) {
                   totalOccurrences += 1
                }
            }
        }
        if reviews.contains(key) || reviews.contains(key.capitalized) {
            totalOccurrences += 1
        }
        topicOccurrences[key] = totalOccurrences
    }
    return topicOccurrences
}

let topics = ["Price": ["cheap", "expensive", "price"], "Bussiness specialist" : ["gnome", "gnomes"],
              "Harry Shrub" : ["harry shrub"]]
let reviews = ["Harry shrub did a great job with my garden, but I expected more gnomes for the price", "I love my new gnomes, they are so cute! My dog loves them too! Thanks Harry!", "Very expensive at fifty dollars per gnome. Next time I will from Cheap Gnomes Warehouse"]

print(countTopicOccurrences(topics: topics, reviews: reviews))

struct Meal {
    let name: String
    let ingredients: [String]
}

func getUniqueMealCount(meals: [Meal]) -> Int {
     guard meals.count > 0 else {
         return 0
     }
    
    var totalUniqueMeals = 0
    var arrayOfMealsDict = [[String: String]]()
    for items in meals {
        let sortedIngredients = items.ingredients.sorted{$0 < $1}.joined(separator: ",")
        arrayOfMealsDict.append([sortedIngredients: items.name])
    }
    
    print(arrayOfMealsDict.compactMap { $0.keys != $0.keys})

    for items in arrayOfMealsDict {
        for (key, value) in items {
            totalUniqueMeals += 1
        }
    }
    
    print(arrayOfMealsDict)
    
    return totalUniqueMeals
}

let meal1 = Meal(name: "American", ingredients: ["lettuce", "cheese", "olives", "tomato"])
let meal2 = Meal(name: "Mexican", ingredients: ["lettuce", "cheese", "pepper", "tomato"])
let meal3 = Meal(name: "French", ingredients: ["lettuce", "cheese", "pepper", "tomato"] )
let meal4 = Meal(name: "Continental", ingredients: ["lettuce", "cheese", "olives", "tomato"])
let mealsArray = [meal1, meal2, meal3, meal4]

getUniqueMealCount(meals: mealsArray)

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

var array = ["Alex", "Matt", "Jillian", "Tom","Matt", "Jane", "Alex","Matt"]
// Display the output with the element that has highest occurence
func findHighestOccurence(_ arr: [String]) {
  var sum = 1
  var dict = [[String: Any]]()
  for i in 0..<arr.count {
     let firstVal = arr[i]
     sum = 1
     for j in i+1..<arr.count {
         let nextVal = arr[j]
         print("second...\(arr[j])")
         if firstVal == nextVal {
             print("Matched.. \(firstVal), \(nextVal)")
             sum += 1
             print("sum.. \(sum)")
          }
          if j == arr.count-1 {
              if sum == 0 {
                  sum = 1
              }
              let keyExists = dict.first(where: { $0[firstVal] as! String == firstVal})

              if keyExists == nil {
                  dict.append([firstVal: sum])
              }
              print(dict)
          }
     }
  }
    print(dict)
}
findHighestOccurence(array)

/*Find maximum consecutive ones */
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var sum = 0
    var max  = 0
    for item in nums {
        if item == 1 {
            sum += 1
            if sum > max {
                max = sum
            }
        } else {
            sum = 0
        }
    }
    return max
}
print(findMaxConsecutiveOnes([0,1,3,1,1,1,0,1,1,1,1,0]))

/*Find even number of digits*/
func findEvenDigits(_ nums:[Int]) -> Int {
    var sum = 0
    for item in nums {
        if isEvenCount(num: item) {
            sum += 1
        }
    }
    return sum
}

func isEvenCount(num: Int) -> Bool {
    var count = 0
    var temp = 0
    while (temp != 0) {
        count += 1
        temp /= 10
    }
    return count % 2 == 0
}

print(findEvenDigits([12, 345, 2, 6, 7896]))

/*Sort Array*/
func sortArray(_ sortedArray: inout [Int]) -> [Int] {
    var temp = 0
    for i in 0..<sortedArray.count {
        for j in i+1..<sortedArray.count {
            if sortedArray[i] > sortedArray[j] {
                temp = sortedArray[i]
                sortedArray.swapAt(i, j)
                sortedArray.remove(at: j)
                sortedArray.insert(temp, at: j)
            }
        }
    }
    return sortedArray
}

var arr = [3,8,10,1,20,2,4]
print(sortArray(&arr))

/* Sort with Swift sort method*/
var string = ["An", "Array", "Hello", "Is", "Oh", "This", "Unsorted", "World"]
let sortedByLength = string.sorted(by: {lhs, rhs in
    return lhs.count > rhs.count
})
//let sortedByLength = string.sorted()
print(sortedByLength)

/* Sort Array*/
var sortedArray = [0,1,2,3,5,6,8,9].sorted(by: {$0 < $1})
print(sortedArray)

/* Reverse Array*/
func reverseArray(_ arr: inout [Int]) -> [Int] {
    let count = arr.count
    for i in 0..<count/2 {
        (arr[i], arr[count - i - 1]) = (arr[count - i - 1], arr[i])
    }
    return arr
}
print(reverseArray(&arr))

/* First Non repeating character in string */
func nonRepeatingChar(repeatingString: String) -> String {
    let characters = repeatingString.map{String($0)}
    var counts: [String: Int] = [:]
    for char in characters {
        counts[char] = (counts[char] ?? 0) + 1
    }
    let nonRepeatingCharacers = characters.filter({counts[$0] == 1})
    return nonRepeatingCharacers.first ?? ""
}
print(nonRepeatingChar(repeatingString: "SimpleSam"))

/* Array of tuples */
func arrayOfTuples(_ arr: inout [Int]) {
    var arrayOfTuples = [(Int, Int)]()
    for (index, element) in arr.enumerated() {
        arrayOfTuples += [(index, element)]
    }
}

var list = [Int](1...5)
print(arrayOfTuples(&list))

/* Get second largest number in array */
func secondLargestNumber(arr: [Int]) -> Int {
    var largest = 0
    var secondLargest = 0
    for index in 0..<arr.count {
        let val = arr[index]
        if val > largest {
            secondLargest = largest
            largest = val
        } else if val > secondLargest, val != largest {
            secondLargest = val
        }
        
        if secondLargest == 0 {
            print("Invalid input")
        }
    }
    return secondLargest
}
print(secondLargestNumber(arr: [10,1,2,5,7]))
