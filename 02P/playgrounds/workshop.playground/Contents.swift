/*:
 ##  Swift Workshop
 This section is more of a crash-course of the other playgrounds; and it is **strongly** recommended that you go through each of those playgrounds after completing this plaground
 
 That said, in this workshop we will cover some of the unique langauge featuers provided by Swift
 1. Type Inference
 2. Built in support for Optionals
 3. Value/Reference types
 4. Functions and Extensions
 5. Closures
 6. Guards
 7. Protocols
 */

import Foundation

/*:
 ### 1. Type Inference
 Swift can be both statically and dynamically typed
 */
var str = "Hello, playground"
var int = 1
var typed: String = "Hello, typed variable"

//: Type typically inferred on compile time
func getSomething() -> Int {
    return 0
}
var something = getSomething()

/*:
 ### 2. Optionals
 Swift has support for optionals baked into the language
*/
var optionalName: String? = nil
var explicitOptionalName: Optional<String> = nil

//: Optional values helps to deal with errors associated with nils - which is often the cause for headaches
if let name = explicitOptionalName {
    print(name)
}

//: Optionals can also be unwrapped with defaults
var defaultName = optionalName ?? "steve"

/*: Optionals always need to be unwrapped when acessing their properties
 - Note: their properties will also be optional
 */
var optionalProperties = optionalName?.count

/*:
 ### 3. Value and Reference types
 Swift provides structs and classes to structure your data. Structs are **value** types and classes are **reference** types
 */

struct StructName {
    var first: String
    var middle: String?
    var last: String
}

class ClassName {
    let first: String
    let middle: String?
    var last: String
    
    init(first: String, middle:String?, last:String) {
        self.first = first
        self.middle = middle
        self.last = last
    }
}

/*: When allocating structs, if we use `let` that struct values are considered constant (immutable). If a `var` is used, that value is considard mutable
 */
let immutableStructName = StructName(first: "John", middle: nil, last: "Doe")
var mutableStructName = StructName(first: "John", middle: nil, last: "Doe")

mutableStructName.last = "Darren"

/*: However with reference types like classes, this is not the case. `var` and `let` only denotes the mutability of the reference, but not any references/values referenced by the reference
 */

let immutableClassName = ClassName(first: "John", middle: nil, last: "Doe")
var mutableClassName = ClassName(first: "John", middle: nil, last: "Doe")

immutableClassName.last = "Darren"
mutableClassName.last = "Darren"


/*:
 ### 4. Functions and Extentions
 With swift, functions are considered first-class citizens, i.e functions can live outside of a class/singleton definition
 */

func getName() -> String {
    return "steve"
}

//: Swift functions supports multiple return types
func getNames() -> (String, String) {
    return ("Steve", "Rogers")
}

//: Swift also allows extension functions, a way to extent functionaity without having to inherit a given base type
extension ClassName {
    func fullName() -> String {
        return "\(self.first) \(self.middle ?? "") \(self.last)"
    }
}

immutableClassName.fullName()

/*:
 ### 5. Closures
 Closures are self-contained functions that are defined only with the arguments and returns
 - Note: Closures are commonly known as blocks / lamdas in other programming languages
 */
var checkAgeClosure: (Int) -> Bool = { (age) in age > 18 }

/*:
 Closures are often used in place of arguments, where functional logic needs to be replaced dynamicaly
 */
var shortName = ClassName(first: "Jake", middle: nil, last: "Wharton")

var checkNameLengthClosure:(Int) -> Bool = { (length) in  length > 4 }

func printIfNameIsShort(name: ClassName, condition: (Int) -> Bool){
    if(condition(name.first.count)){
        print("name is long")
    }else{
        print("name is short")
    }
}

/*: Closures allows us to pass conditionals as function arguments
 - Note: Closure block can be lifted out of the function, if it is the last argument to be passed in
 */
printIfNameIsShort(name: shortName, condition: checkNameLengthClosure)
printIfNameIsShort(name: shortName) { (length) -> Bool in length > 3 }

/*:
 ### 5. Guards
 guard are a type of control structures that helps control flow out of the block - if one or more conditions aren’t met.
 - Note: This is similar to a `if` then `throw`/`return`
 */

func printIfValid(name:String){
    guard name.count < 4 || name.count > 5 else {
        print("\(name) is not valid")
        return
    }
    
    print("\(name) is valid")
}

printIfValid(name: "Steven")

//: Guards are often used to type cast objects on runtime, to break out of scope if the given conditions are not met
func printValidNames(first:String?, last:String?){
    guard
        let first = first,
        let last = last
        else {
            print("invalid name")
            return
            
    }
    print("\(first) \(last) is valid")
}

printValidNames(first: "Steve", last: nil)
printValidNames(first: "Steve", last: "Rogers")
