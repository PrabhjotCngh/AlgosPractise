import UIKit

//MARK: - Unwrapping techniques - if let and guard

struct PrimaryStudent {
    let firstName: String
    let lastName: String
    var middleName: String?
    var grade: String?
}

var primaryStudent = PrimaryStudent(firstName: "John", lastName: "Doe")
primaryStudent.middleName = "Johnson"
primaryStudent.grade = "A"

/*
if let middleName = student.middleName, let grade = student.grade {
    print(middleName)
    print(grade)
} */

if let _ = primaryStudent.grade {
    print("Student has been graded")
}

func displayStudent(student: PrimaryStudent) {
    
    guard let middleName = student.middleName,
          let grade = student.grade else {
        return
    }
    
    print(middleName, grade)
}

displayStudent(student: primaryStudent)

//MARK: - Variable Shadowing - Using same variable name as a global variable to unwrap the optional in if let statement is called as variable shadowing

struct SecondaryStudent: CustomStringConvertible {
    
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

let secondaryStudent = SecondaryStudent(firstName: "John", lastName: "Doe", middleName: "Smith", grade: "A")

print(secondaryStudent)

//MARK: - Return Optional Strings

struct TertiaryStudent {
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

let tertiaryStudent = TertiaryStudent(firstName: "John", lastName: "Doe")

func createGreetingMessage(student: TertiaryStudent) -> String {
   let message = """
        Dear \(student.displayName ?? "Student"), Welcome to Swift University
    """
    return message
}

let message = createGreetingMessage(student: tertiaryStudent)
print(message)

//MARK: - Chaining Optionals

struct Grade {
    let gpa: Double?
    let letter: String?
}

struct UniversityStudent {
    let firstName: String
    let lastName: String
    let grade: Grade?
}

let universityStudent = UniversityStudent(firstName: "John", lastName: "Doe", grade: Grade(gpa: 3.2, letter: "B"))

/*
if let grade = student.grade {
    if let gpa = grade.gpa {
        //print(gpa)
    }
} */

print(universityStudent.grade?.gpa ?? "N/A")

//MARK: - Optionals and Booleans


enum UserAgreement: RawRepresentable {
    case accepted
    case rejected
    case notSet
    
    init(rawValue: Bool?) {
        switch rawValue {
            case true?: self = .accepted
            case false?: self = .rejected
            default: self = .notSet
        }
    }
    
    var rawValue: Bool? {
        switch self {
            case .accepted: return true
            case .rejected: return false
            case .notSet: return nil
        }
    }
    
}

let userAgreement = UserAgreement(rawValue: true)

switch userAgreement {
    case .accepted:
        print("accepted")
    case .rejected:
        print("rejected")
    case .notSet:
        print("notSet")
}


//MARK: - Force Unwrapping

struct Student {
    let firstName: String
    let lastName: String
    let grade: String?
}

let student = Student(firstName: "John", lastName: "Doe", grade: nil)

//print(student.grade!)

guard let url = URL(string: "aa bbb cc") else {
    fatalError("URL is not defined!")
}

print(url)
