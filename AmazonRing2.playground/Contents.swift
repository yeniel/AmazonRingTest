import UIKit

func findReviewScore(review: String, prohibitedWords: [String]) -> Int {
    var allowedSubs: [String] = [review.lowercased()]

    for prohibited in prohibitedWords {
        var newAllowedSubs: [String] = []

        for sub in allowedSubs {
            newAllowedSubs += splitInAllowedWords(review: sub, prohibited: prohibited)
        }

        allowedSubs = newAllowedSubs
    }

    return allowedSubs.max(by: { $0.count < $1.count })?.count ?? 0
}

func splitInAllowedWords(review: String, prohibited: String) -> [String] {
    var alloweds: [String] = []
    var subReview: String = review

    while !subReview.isEmpty {
        guard let nextLowerIndex = subReview.range(of: prohibited)?.lowerBound else {
            if alloweds.isEmpty {
                alloweds.append(subReview)
            }

            return alloweds
        }
        guard let previousUpperIndex = subReview.range(of: prohibited)?.upperBound else {
            return alloweds
        }

        let lowerIndex = subReview.index(nextLowerIndex, offsetBy: 1)
        let upperIndex = subReview.index(previousUpperIndex, offsetBy: -1)

        alloweds.append(String(subReview[..<upperIndex]))
        alloweds.append(String(subReview[lowerIndex...]))
        subReview = String(subReview[lowerIndex...])
    }

    return alloweds
}

var review: String
var prohibitedWords: [String]

review = "GoodProductButScrapAfterWash"
prohibitedWords = ["crap", "odpro"]
print(findReviewScore(review: review, prohibitedWords: prohibitedWords))
print("Output should be: 15\n")

review = "FastDeliveryOkayProduct"
prohibitedWords = ["eryoka", "yo", "eli"]
print(findReviewScore(review: review, prohibitedWords: prohibitedWords))
print("Output should be: 11\n")

review = "ExtremeValueForMoney"
prohibitedWords = ["tuper", "douche"]
print(findReviewScore(review: review, prohibitedWords: prohibitedWords))
print("Output should be: 20\n")


