import UIKit

// Soru 1:
func removeChar(text:String, repeatCount : Int)-> String{
    
    var liste = [Character: Int]()
    
    for char in text{
        if let _ = liste[char]{
            liste[char]! += 1
        }else{
            liste[char] = 1
        }
    }
    
    for (char, count) in liste{
        if count >= repeatCount, char != " "{
            liste.removeValue(forKey: char)
        }
    }
    
    var returnText = ""
    for c in text{
        if liste.keys.contains(c){
            returnText.append(c)
        }
    }
    
    return returnText
}

print(removeChar(text: "aaba kouq bux", repeatCount: 3))

// Soru 2:
func repeatString(text: String){
    
    var liste = [String: Int]()
    let text2 = text.lowercased().replacingOccurrences(of: ".", with: "")
    let fullNameArr = text2.components(separatedBy: " ")
    
    for kelime in fullNameArr{
        if !kelime.isEmpty{
            if let _ = liste[kelime]{
                liste[kelime]! += 1
            }else{
                liste[kelime] = 1
            }
        }
        
    }
    
    print(liste)
}
repeatString(text: "egemen    merhaba nasılsınız . iyiyim siz nasılsınız . bende iyiyim. Egemen. ben de")
