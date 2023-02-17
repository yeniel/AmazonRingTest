import UIKit

func numberOfFamilies(logins: [String]) -> Int {
    var families = 0
    var sortedLogins = logins.sorted()
    var login1: (value: String, count: Int)
    var login2: (value: String, count: Int)
    var login1Index = 0
    var login2Index = 0

    while login1Index < sortedLogins.count {
        login1 = (value: sortedLogins[login1Index], count: 1)

        while login1Index + 1 < sortedLogins.count, sortedLogins[login1Index] == sortedLogins[login1Index + 1] {
            login1.count += 1
            login1Index += 1
        }

        login2Index = (login1Index + 1) % sortedLogins.count
        login2 = (value: sortedLogins[login2Index], count: 1)

        while login2Index + 1 < sortedLogins.count, sortedLogins[login2Index] == sortedLogins[login2Index + 1] {
            login2.count += 1
            login2Index += 1
        }

        if isFamily(login1: login1.value, login2: login2.value) {
            families += login1.count * login2.count
        }

        login1Index += 1
    }

    return families
}

func numberOfFamilies3(logins: [String]) -> Int {
    var families = 0
    var sortedLogins: [(login: String, count: Int)] = []
    var map: [String: Int] = [:]

    for login in logins {
        if let count = map[login] {
            map[login] = count + 1
        } else {
            map[login] = 1
        }
    }

    for login in map.keys.sorted() {
        if let count = map[login] {
            sortedLogins.append((login: login, count: count))
        }
    }

    for index in 0..<sortedLogins.count {
        let login1 = sortedLogins[index]
        let login2 = sortedLogins[(index + 1) % sortedLogins.count]

        if isFamily(login1: login1.login, login2: login2.login) {
            families += login1.count * login2.count
        }
    }

    return families
}

func isFamily(login1: String, login2: String) -> Bool {
    let index0 = login1.index(login1.startIndex, offsetBy: 0)
    let index1 = login1.index(login1.startIndex, offsetBy: 1)
    let index2 = login1.index(login1.startIndex, offsetBy: 2)

    if areRotatedCharacters(char1: login1[index0], char2: login2[index0]),
        areRotatedCharacters(char1: login1[index1], char2: login2[index1]),
        areRotatedCharacters(char1: login1[index2], char2: login2[index2])
    {
        return true
    }

    return false
}

func areRotatedCharacters(char1: Character, char2: Character) -> Bool {
    let asciiA = 97
    let asciiZ = 122
    let alphaCount = 26

    if let asciiChar1 = char1.asciiValue, let asciiChar2 = char2.asciiValue {
        return (asciiA + (Int(asciiChar1) - asciiA + 1) % 26) == Int(asciiChar2)
    }

    return false
}

var logins: [String]

logins = ["corn", "horn", "dpso", "eqtp", "corn"]
print(numberOfFamilies(logins: logins))
print(numberOfFamilies3(logins: logins))
print("Output should be 3\n")

logins = ["bbb", "aaa", "bbb"]
print(numberOfFamilies(logins: logins))
print(numberOfFamilies3(logins: logins))
print("Output shoudl be: 2\n")

logins = ["cbu", "bat", "cbu"]
print(numberOfFamilies(logins: logins))
print(numberOfFamilies3(logins: logins))
print("Output shoudl be: 2\n")
