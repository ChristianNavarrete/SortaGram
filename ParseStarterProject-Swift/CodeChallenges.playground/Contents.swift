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


func howManyOdds(array:[A) {
    
    
    
    
    
    
}

