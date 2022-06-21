import UIKit

//MARK: - Unwrapping techniques - if let and guard

struct Student {
    let firstName: String
    let lastName: String
    var middleName: String?
    var grade: String?
}

var student = Student(firstName: "John", lastName: "Doe")
student.middleName = "Johnson"
student.grade = "A"

/*
if let middleName = student.middleName, let grade = student.grade {
    print(middleName)
    print(grade)
} */

if let _ = student.grade {
    print("Student has been graded")
}

func displayStudent(student: Student) {
    
    guard let middleName = student.middleName,
          let grade = student.grade else {
        return
    }
    
    print(middleName, grade)
}

displayStudent(student: student)

//MARK: - Variable Shadowing - Using same variable name as a global variable to unwrap the optional in if let statement is  called as variable shadowing

struct Student: CustomStringConvertible {
    
    var description: String {
        var studentDescription = "\(firstName) "
        
        // Variable shadowing
        if let middleName = middleName {
            studentDescription += "\(middleName)"
        }
        
        studentDescription = " \(lastName) "
        
        // Variable shadowing
        if let grade = grade {
            studentDescription += "\(grade)"
        }
        
        return studentDescription
    }
    
    let firstName: String
    let lastName: String
    let middleName: String?
    let grade: String?
}

let student = Student(firstName: "John", lastName: "Doe", middleName: "Smith", grade: "A")

print(student)

//MARK: - Return Optional Strings

struct Student {
    let firstName: String?
    let lastName: String?
    
    //switch case binding
    var displayName: String? {
        switch (firstName, lastName) {
            case let (first?, last?): return "\(first) \(last)"
            case let (first?, nil): return first
            case let (nil, last?): return last
            default: return nil
        }
    }
}

let student = Student(firstName: "John", lastName: "Doe")

func createGreetingMessage(student: Student) -> String {
   let message = """
        Dear \(student.displayName ?? "Student"), Welcome to Swift University
    """
    return message
}

let message = createGreetingMessage(student: student)
print(message)

//MARK: - Chaining Optionals
