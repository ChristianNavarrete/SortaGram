//: Playground - noun: a place where people can play

import Cocoa

//Write a function that tells you how many words are in a string




var str = "What's brackin' world, today is a new day!"

func howManyWords(sentence:String) -> Int {
    
    var wordsArray = [String]()
    
    let words = sentence.characters.split{$0 == " "}.map(String.init)

    for word in words {
        wordsArray.append(word)
    }
    
    return wordsArray.count
    
}

howManyWords(str)


//---------------------------------------------------------------------------

//Write a function that returns all the odd elements from an array


func howManyOdds(array:[Int]) -> [Int] {
    
    var oddArray = [Int]()
    
    for item in array {
        
        if item % 2 != 0 {
            oddArray.append(item)
        }

    }
    
    return oddArray
    
}


howManyOdds([1,2,3,4,5,6,7,8,9,10])


//-----------------------------------------------------------------------------











