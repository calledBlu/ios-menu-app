//
//  MenuAppTests.swift
//  MenuAppTests
//
//  Created by Blu on 2023/05/18.
//

import XCTest
@testable import MenuApp

final class MenuAppTests: XCTestCase {
    var sut: DateProvider!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = DateProvider()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
    }

    func test_provider가_days를_정상적으로_가져오는가() {
        // given
        var correct: [String] = [""]

        // when
        sut.configureCalendar()
        for num in 1..<32 {
            correct.append("\(num)")
        }

        // then
        XCTAssertEqual(sut.menuCalendar.days, correct)
    }

    func test_provider로_가져온_날짜의_년월을_format에_맞게_변환하는가() {
        // given
        let correct = "2023년 05월"

        // when
        let result = sut.updateCalendarTitle()

        // then
        XCTAssertEqual(result, correct)
    }

    func test_date를_변경하는_경우_days와_title이_올바르게_변경되는가() {
        // given
        var correctDays: [String] = ["", "", "", "", "", ""]
        let correctTitle = "2023년 04월"

        // when
        sut.updateDate(Calendar.current.date(byAdding: DateComponents(month: -1),
                                             to: sut.menuCalendar.calendarDate) ?? Date())
        sut.configureCalendar()

        let resultDays = sut.menuCalendar.days
        let resultTitle = sut.updateCalendarTitle()

        for num in 1..<31 {
            correctDays.append("\(num)")
        }

        // then
        XCTAssertEqual(resultDays, correctDays)
        XCTAssertEqual(resultTitle, correctTitle)
    }
}
