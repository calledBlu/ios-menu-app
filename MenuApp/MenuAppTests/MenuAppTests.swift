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
        let correct = 35

        // when
        let metaData = try? sut.generateMonthMetaData(for: Date())
        let newDays = try? sut.generateDaysInMonth(for: sut.sendCurrentCalendarDate())

        sut.configureMonthMetaData(metaData)
        sut.updateDaysInMonth(newDays)

        // then
        XCTAssertEqual(sut.sendDaysInMonth().count, correct)
    }

    func test_provider로_가져온_날짜의_년월을_format에_맞게_변환하는가() {
        // given
        let correct = "2023년 05월"

        // when
        sut.formatter.changeFormat(to: .yearAndMonth)
        let result = sut.formatter.string(from: sut.sendCurrentCalendarDate())

        // then
        XCTAssertEqual(result, correct)
    }

    func test_date를_변경하는_경우_days와_title이_올바르게_변경되는가() {
        // given
        let correctDays = 42
        let correctTitle = "2023년 04월"

        // when
        let april = sut.calendar.date(byAdding: DateComponents(month: -1),
                                   to: sut.sendCurrentCalendarDate())

        let metaData = try? sut.generateMonthMetaData(for: Date())
        let days = try? sut.generateDaysInMonth(for: sut.sendCurrentCalendarDate())

        sut.configureMonthMetaData(metaData)
        sut.updateDaysInMonth(days)
        sut.updateCalendarDate(april)

        let newMetaData = try? sut.generateMonthMetaData(for: sut.sendCurrentCalendarDate())
        let newDays = try? sut.generateDaysInMonth(for: sut.sendCurrentCalendarDate())

        sut.configureMonthMetaData(newMetaData)
        sut.updateDaysInMonth(newDays)

        let resultDays = sut.sendDaysInMonth().count
        sut.formatter.changeFormat(to: .yearAndMonth)
        let resultTitle = sut.formatter.string(from: sut.sendCurrentCalendarDate())

        // then
        print(sut.sendDaysInMonth())
        XCTAssertEqual(resultDays, correctDays)
        XCTAssertEqual(resultTitle, correctTitle)
    }

    func test_dateFormatter의_dateformat만_변경하여_사용할_수_있는가() {
        // given
        let today = Date()
        let calendarTitleResult = "2023년 05월"
        let detailTitleResult = "05월 27일 토요일"
        let listTextResult = "2023년 05월 27일"

        // when
        sut.formatter.changeFormat(to: .yearAndMonth)
        let calendarTitle = sut.formatter.string(from: today)

        sut.formatter.changeFormat(to: .monthAndDay)
        let detailTitle = sut.formatter.string(from: today)

        sut.formatter.changeFormat(to: .list)
        let listText = sut.formatter.string(from: today)

        // then
        XCTAssertEqual(calendarTitle, calendarTitleResult)
        XCTAssertEqual(detailTitle, detailTitleResult)
        XCTAssertEqual(listText, listTextResult)
    }
}
