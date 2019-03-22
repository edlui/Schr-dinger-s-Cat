/*:
 ## Task 1
 
 ### 1.1 Collecting your data
 Silly Name Tester - A swifty throwback
 
 Create a program that reads the user's name and then responds with a message based on the given name. It shall do the following
 
 1. Print `What's your name?`
 2. Read the user's input
 3. If the name matches your name, then print `Awesome name`
 4. Otherwise, print `<name> is a silly, silly silly silly`(... 100 more times) ` name`
 */

import Foundation

print("What's your name?")
let name = readLine() ?? "Chris"
let userName = readLine() ?? "Eddie"
if userName == name{
    print("Awesome Name.")
}else{
    print("\(userName) is a silly, ")
    for _ in 1...100{
        print("silly ")
    }
    print("name.")
}

/*:
 ### 1.2 Packaging your data

 structs are often used as data classes, of which the only purpose is to passively contain data with no business login associated with the given type.

 Extend the previous program and ask extra information from the user. Store the collected information inside of the following data structure. Additionally, implement the validate function with use a `guard` to ensure that the age is greater than or equal to 18 and less than 999
 */

struct Profile {
    let firstName: String
    let lastName: String
    let age: Int?
}

func validate(firstName: String, lastName:String, age:Int?) -> Profile? {
    // TODO
    // 1. add a guard to check if the age is not optional
    // 2. add a guard to check if the age is in range
    // 3. wrap the collected data in the struct and return
    let firstName = firstName
    let lastName = lastName

    guard let age = age else{
        return nil
    }

    guard age >= 18 && age <= 99 else {
        return nil
    }

    let ProfilObj = Profile(firstName: firstName, lastName: lastName, age: age)

    return ProfilObj
}

let ProfilObj2 = Profile(firstName: "KK", lastName: "LUI", age: 23)

print(validate(firstName: ProfilObj2.firstName, lastName: ProfilObj2.lastName, age: ProfilObj2.age)!)


/*:
 ## Task 2 Schrodinger's Cat 😼

 Schrodinger's Cat is a thought experiment physicists use to explain the uncertain nature of quantum states. According to [Wikipedia](https://en.wikipedia.org/wiki/Schrodinger%27s_cat),

 * Experiment:
 Schrödinger's cat; a **cat**, a **flask of poison**, and a radioactive source are placed in a **sealed box**. If an internal monitor (e.g. Geiger counter) detects radioactivity (i.e. a single atom decaying), the flask is shattered, releasing the poison, which kills the cat. The Copenhagen interpretation of quantum mechanics implies that after a while, the cat is simultaneously alive and dead. Yet, when one looks in the box, one sees the cat either alive or dead not both alive and dead. This poses the question of when exactly quantum superposition ends and reality collapses into one possibility or the other.

 - SeeAlso: watch this video explanation by [minute phyics](https://www.youtube.com/watch?v=IOYyCHGWJq4)

 For this task, we will adopt the Einstein's version of this famous thought experiment - i.e instead of the sealed box, it will be a sound-proof bunker; instead of the poison, it will be randomly detonated explosives. The cat will still be a cat however 🙀

 ### 2.1 Design the experiment
 1. You've been provided with a struct for the `Cat` and protocols for `Explosive` and `Bunker`. Use these protocols and complete the implementation.
 2. Implement the method body for `checkIfTheCatIsAlive` function
 */

struct Cat {
    let name: String
    //: - Note: nil to represent that cat is in a super-position, true and false means the cat is alive and not respectively.
    var isAlive: Bool?
}

protocol Explosive {
    //: - TODO: when detonated, the explosives should go off 50% of the time
    func detonate () -> Bool
}

class explosiveClass : Explosive{
    func detonate () ->Bool{
        let checker = Int.random(in: 0..<10)
        if(checker < 5){
            return true
        }
        return false
    }
}

protocol Bunker {
    //: - TODO: when initialising cat's `isAlive` should be set to nil, to represent that cat is in a super-position
    init(occupent: Cat, explosive: Explosive)

    var occupent: Cat { get set }
    var explosive: Explosive { get }

    //: - TODO: By the mere action of opening the bunker door, determines the state of the cat's life.
    func open()
}

class bunkerClass: Bunker{
    required init(occupent: Cat, explosive: Explosive) {
        self.occupent = Cat(name: occupent.name, isAlive: nil)
        self.explosive = explosive
    }
    
    var occupent: Cat

    var explosive: Explosive

    func open() {
        let ExplosionResult:Bool = self.explosive.detonate()
        if ExplosionResult == true{
            self.occupent.isAlive = false
        }
        if ExplosionResult == false{
            self.occupent.isAlive = true
        }
        print(ExplosionResult)
        checkIfTheCatIsAlive(cat: self.occupent)
    }

}


func checkIfTheCatIsAlive(cat: Cat) {
    // TODO: if the cat is alive, print "Its alive!!! 😸"
    // TODO: if the cat is dead, print "Oh no 😿"
    // TODO: if the cat is neither alive nor dead, print "Its cat-tum superposition! 🤷‍♂️😼"
    if cat.isAlive == true{
        print("Its alive!!! 😸")
    }
    if cat.isAlive == false{
        print("Oh no 😿...")
    }
    if cat.isAlive == nil{
        print("Its cat-tum superposition! 🤷‍♂️😼")
    }
}


/*:
 ### 2.2 Run the experiment
 Using the implementations of the protocols and the functions, write the following program

 Your program should do the following
 1. Create a 'living' cat named "Jellie"
 2. Create a TNT
 3. Create a Bunker and place Jellie and the TNT inside of the bunker,
 4. Query the state of the cat
 - Note:  at this point, the cat should be neither alive nor dead.
 5. Open the bunker to find out whether the explosives exploded or not (wave function collapsed!)
 6. Query the state of the cat,
 * if the cat is alive, print `Its alive!!!`
 * if the cat is dead, print `Oh no :(`
 - Note:  at this point, the cat should be either alive or dead; but not both
 */
var CopyCat = Cat(name: "Jellie", isAlive: true )
let TNT = explosiveClass()
let Door: Bunker = bunkerClass(occupent: CopyCat, explosive: TNT)
Door.open()

/*:
 ### 2.3 Tweaking the Experiment

 Implement the following protocol for `DangerousBunker` and re-write the program to make use of the new `DangerousBunker`'s implementation

 - Note: The difference of `DangerousBunker` compared to `Bunker` should be that,
 * The DangerousBunker takes in more than just one explosive
 * When one explosive is exploded on detonation, all explosives will explode as a chain reaction
 */

protocol DangerousBunker {
    init(occupent: Cat, explosives: [Explosive])
    var occupent: Cat { get set }
    var explosives: [Explosive] { get }
    func open()
}

class dangerousbunkerClass: DangerousBunker{

    required init(occupent: Cat, explosives: [Explosive]) {
        self.occupent = Cat(name: occupent.name, isAlive: nil)
        self.explosives = explosives
    }

    var occupent: Cat

    var explosives: [Explosive]

    func open() {
        let explosivesCount = Int.random(in: 1..<11)
        var explosionReduce = ""
        
        for _ in 0..<explosivesCount{
            self.explosives.append(explosiveClass())
        }
        
        let explosionResult = explosives.map{(explosionClass) -> Bool in explosionClass.detonate()}
        
        print("There is \(explosionResult.count) exploives in the room, and result is \(explosionResult).")
        
        if explosionResult.contains(true){
            explosionReduce = explosionResult.reduce("true") {(text, explosionResult) in "\(text)"}
        }else if explosionResult.contains(false){
            explosionReduce = explosionResult.reduce("false") {(text, explosionResult) in "\(text)"}
        }
        
        if explosionReduce == "true" {
            self.occupent.isAlive = false
            checkIfTheCatIsAlive(cat: occupent)
        }else if explosionReduce == "false"{
            self.occupent.isAlive = true
            checkIfTheCatIsAlive(cat: occupent)
        }
    }
}

var CopyCat2 = Cat(name: "Jellie", isAlive: true )
var TNT2 = [Explosive]()
let Door2: DangerousBunker = dangerousbunkerClass(occupent: CopyCat2, explosives: TNT2)
Door2.open()

//: - Note: Extra points if made use of higher order functions such as `.map` and `.reduce` to make the `open()` function as *functional* as possible
