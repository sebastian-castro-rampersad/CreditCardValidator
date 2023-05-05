import XCTest
@testable import CreditCardValidator

final class CreditCardValidatorTests: XCTestCase {
    
    /// Card numbers provided from
    /// https://www.paypalobjects.com/en_GB/vhelp/paypalmanager_help/credit_card_numbers.htm
    /// https://docs.adyen.com/development-resources/test-cards/test-card-numbers
    //// https://www.kobzarev.com/other/testoviye-nomera-kreditnyh-kart/
    func testValidData() {
        let values: [(CreditCardType, String)] = [
            (.amex, "3782 8224 6310 005"),
            (.amex, "3714 4963 5398 431"),
            (.amex, "3787 3449 3671 000"),
            (.visa, "4111 1111 1111 1111"),
            (.visa, "4012 8888 8888 1881"),
            (.mastercard, "5500 0000 0000 0004"),
            (.mastercard, "5555 5555 5555 4444"),
            (.mastercard, "5105 1051 0510 5100"),
            (.mastercard, "2222 4107 4036 0010"),
            (.diners, "30569309025904"),
            (.jcb, "3569 9900 1009 5841"),
            (.discover, "6011 0000 0000 0004"),
            (.unionpay, "6250 9470 0000 0014"),
        ]
        values.forEach { (item) in
            print(item.0)
            XCTAssertTrue(CreditCardValidator(item.1).isValid)
            XCTAssertEqual(item.0, CreditCardValidator(item.1).type)
            XCTAssertTrue(CreditCardValidator(item.1).isValid(for: item.0))
        }
    }
    
    func testInvalidData() {
        let values: [(CreditCardType, String)] = [
            (.amex, "3782 8224 6310 006"),
            (.amex, "3714 4963 5398 432"),
            (.amex, "3787 3449 3671 001"),
            (.amex, "3715 6536 866"),
            (.visa, "4111 1111 1111 1112"),
            (.visa, "4012 8888 8888 1882"),
            (.visa, "4222 2222 2222"),
            (.mastercard, "5500 0000 0000 0005"),
            (.mastercard, "5555 5555 5555 4445"),
            (.mastercard, "5105 1051 0510 5101"),
            (.mastercard, "2222 4107 4036 0011"),
            (.mastercard, "2222 4107 4036 0011"),
            (.diners, "30569309025905"),
            (.diners, "30569309021"),
            (.jcb, "3569 9900 1009 5842"),
            (.jcb, "3569 9900 1009 3"),
            (.discover, "6011 0000 0000 0005"),
            (.discover, "6011 0000 001"),
            (.unionpay, "6250 9470 0000 0015"),
        ]
        values.forEach { (item) in
            print(item.0)
            XCTAssertFalse(CreditCardValidator(item.1).isValid)
            XCTAssertEqual(item.0, CreditCardValidator(item.1).type)
            XCTAssertFalse(CreditCardValidator(item.1).isValid(for: item.0))
        }
    }

    static var allTests = [
        ("testValidData", testValidData),
        ("testInvalidData", testValidData),
    ]
}
