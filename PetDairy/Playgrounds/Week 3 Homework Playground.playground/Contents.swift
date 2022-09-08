import UIKit

// MARK: - Assignment 1

var itemPrices = [25.0, 3.50, 2.25, 32.50, 7, 10, 12.25]

func totalAmountAfterDiscount(totalAmount: Double, discountPercentage: Double) -> Double {
		let discountedAmount = totalAmount * discountPercentage / 100
		return totalAmount - discountedAmount
}

totalAmountAfterDiscount(totalAmount: 50, discountPercentage: 5)

// MARK: - Assignment 2

func totalAmountAfterDiscount(totalAmount: Double, defaultDiscountPercentage: Double = 10.0) -> Double {
		let discountedAmount = totalAmount * defaultDiscountPercentage / 100
		return totalAmount - discountedAmount
}

totalAmountAfterDiscount(totalAmount: 50)

// MARK: - Assignment 3

typealias Discount = (Double, String) -> Double

func discountForSeason(_ totalAmount: Double, _ season: String) -> Double {
		let discount: Double
		switch season {
		case "Thanksgiving":
				discount = 10
		case "Christmas":
				discount = 15
		case "Newyear":
				discount = 20
		default:
				discount = 5
		}
		return totalAmountAfterDiscount(totalAmount: totalAmount, discountPercentage: discount)
}


func printDiscount(_ discount: Discount, _ totalAmount: Double, _ season: String) {
		let result = discount(totalAmount, season)
		print("The total amount after discount for \(season) is \(result)")
}

var discount = discountForSeason
printDiscount(discountForSeason, 50, "Newyear")


// MARK: - Assignment 4

let calculateDiscount = { (totalAmount: Double, discountType: Double) in
		let discountedAmount = totalAmount * discountType / 100
		print(totalAmount - discountedAmount)
}

calculateDiscount(50, 20)

print("-----------------------------------\n")

// MARK: - Assignment 5

itemPrices.map {print($0 + ($0 * 0.5))}


// MARK: - Assignment 6

let discountTypes = ["Default": 5, "Thanksgiving": 10, "Christmas": 15, "Newyear": 20]
let sortedDiscounts = discountTypes.sorted { (first, second) -> Bool in
		return first.value > second.value
}

print("-----------------------------------\n")
print(sortedDiscounts)

// MARK: - Assignment 7

enum DiscountType: Double, Comparable, CaseIterable {
		case standard = 5
		case thanksgiving = 10
		case christmas = 15
		case newyear = 20
		
		static func <(lhs: DiscountType, rhs: DiscountType) -> Bool {
				return lhs.rawValue < rhs.rawValue
		}
}

func printDiscount(for discountType: DiscountType) {
		switch discountType {
		case .standard:
				print("\(Int(discountType.rawValue))%")
		case .thanksgiving:
				print("\(Int(discountType.rawValue))%")
		case .christmas:
				print("\(Int(discountType.rawValue))%")
		case .newyear:
				print("\(Int(discountType.rawValue))%")
		}
}

print("-----------------------------------\n")
printDiscount(for: .newyear)
print("-----------------------------------\n")


// MARK: - Assignment 8

struct Inventory {
		var itemPrices = [25.0]
		var discountPercentages: [Double] = []
		
		var currentDiscountedAmount: Double {
				return totalAmountAfterDiscount(totalAmount: itemPrices[0], discountPercentage: 15)
		}
		
		// MARK: - Assigment 9
		lazy var maximumDiscount: Double = {
				for value in DiscountType.allCases {
						discountPercentages.append(value.rawValue)
				}
				return discountPercentages.max() ?? DiscountType.standard.rawValue
		}()
		
		// MARK: - Assignment 10
		
		func caculateTotalAmountAfterDiscount(_ totalAmount: Double, _ discountType: DiscountType) -> Double {
				let discount: Double
				switch discountType {
						
				case .standard:
						discount = discountType.rawValue
				case .thanksgiving:
						discount = discountType.rawValue
				case .christmas:
						discount = discountType.rawValue
				case .newyear:
						discount = discountType.rawValue
				}
				return totalAmountAfterDiscount(totalAmount: totalAmount, discountPercentage: discount)
		}
}

var inventory = Inventory()
print(inventory.currentDiscountedAmount)
print("Maximum Discount: \(Int(inventory.maximumDiscount))%")
print("Total amount after discount: \(inventory.caculateTotalAmountAfterDiscount(50, .newyear))")

// MARK: - Assignment 11

protocol Discount2 {
		var discountType: DiscountType { get }
		var discountPercentage: Double { get }
		func calculateDiscount(totalAmount: Double, discountType: DiscountType) -> Double
}

class TestClass: Discount2 {
		var discountType: DiscountType = .standard
		var discountPercentage: Double = DiscountType.standard.rawValue
		
		func calculateDiscount(totalAmount: Double, discountType: DiscountType) -> Double {
				let discount: Double
				switch discountType {
						
				case .standard:
						discount = discountType.rawValue
				case .thanksgiving:
						discount = discountType.rawValue
				case .christmas:
						discount = discountType.rawValue
				case .newyear:
						discount = discountType.rawValue
				}
				return totalAmountAfterDiscount(totalAmount: totalAmount, discountPercentage: discount)
		}
}

// MARK: - Assignment 12

extension Double {
		func roundToInt() -> Int {
				Int(Darwin.round(self))
		}
}

let test = TestClass()
test.calculateDiscount(totalAmount: 54.30, discountType: .newyear).roundToInt()

var a = 15.3.roundToInt()
var b = 15.5.roundToInt()

// MARK: - Nice to have NSAttributedString

let string = "Four score and seven years ago"
let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 5, length: 5))
attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 11, length: 3))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 15, length: 5))
attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 15, length: 5))
attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 20, length: 6))
attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 26, length: 4))
