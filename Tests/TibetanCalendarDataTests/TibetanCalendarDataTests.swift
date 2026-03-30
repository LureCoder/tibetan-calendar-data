import XCTest
import TibetanCalendarData

final class TibetanCalendarDataTests: XCTestCase {
    private let provider = TibetanCalendarDataProvider.shared
    
    override func setUp() {
        super.setUp()
        // Clear cache before each test
        provider.clearCache()
    }
    
    func test1953January3rdData() {
        // Test data from 1953.json lines 47-66
        guard let dayData = provider.getDayData(year: 1953, month: 1, day: 3) else {
            XCTFail("Failed to get day data for 1953-01-03")
            return
        }
        
        // Test Gregorian date fields
        XCTAssertEqual(dayData.gregorianYear, 1953, "gregorian_year should be 1953")
        XCTAssertEqual(dayData.gregorianMonth, 1, "gregorian_month should be 1")
        XCTAssertEqual(dayData.gregorianDay, 3, "gregorian_day should be 3")
        XCTAssertEqual(dayData.weekday, 0, "weekday should be 0")
        
        // Test Tibetan date fields
        XCTAssertEqual(dayData.tibetanYear, "水龙", "tibetan_year should be 水龙")
        XCTAssertEqual(dayData.tibetanYearElement, "水", "tibetan_year_element should be 水")
        XCTAssertEqual(dayData.tibetanYearAnimal, "龙", "tibetan_year_animal should be 龙")
        XCTAssertEqual(dayData.tibetanMonth, "十一", "tibetan_month should be 十一")
        XCTAssertEqual(dayData.tibetanMonthName, "庄严月", "tibetan_month_name should be 庄严月")
        XCTAssertEqual(dayData.tibetanDay, "十八", "tibetan_day should be 十八")
        
        // Test boolean fields
        XCTAssertFalse(dayData.isLeapDay, "is_leap_day should be false")
        XCTAssertFalse(dayData.isMonthStart, "is_month_start should be false")
        XCTAssertFalse(dayData.isYearStart, "is_year_start should be false")
        XCTAssertFalse(dayData.solarEclipse, "solar_eclipse should be false")
        XCTAssertFalse(dayData.lunarEclipse, "lunar_eclipse should be false")
        
        // Test string fields
        XCTAssertEqual(dayData.festival, "观音菩萨节日", "festival should be 观音菩萨节日")
        XCTAssertEqual(dayData.specialNote, "作何善恶成千万倍", "special_note should be 作何善恶成千万倍")
        XCTAssertEqual(dayData.eclipseDetail, "", "eclipse_detail should be empty string")
    }
    
    func testDateBasedQuery() {
        // Test getting data by Date
        var components = DateComponents()
        components.year = 1953
        components.month = 1
        components.day = 3
        components.hour = 12
        components.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = Calendar.current.date(from: components) else {
            XCTFail("Failed to create date for 1953-01-03")
            return
        }
        
        guard let dayData = provider.getDayData(date: date) else {
            XCTFail("Failed to get day data by date for 1953-01-03")
            return
        }
        
        XCTAssertEqual(dayData.gregorianYear, 1953)
        XCTAssertEqual(dayData.gregorianMonth, 1)
        XCTAssertEqual(dayData.gregorianDay, 3)
        XCTAssertEqual(dayData.tibetanYear, "水龙")
    }
    
    func testMonthDataRetrieval() {
        // Test getting entire month data
        let monthData = provider.getMonthData(year: 1953, month: 1)
        XCTAssertFalse(monthData.isEmpty, "January 1953 should have data")
        
        // Find the specific day in the month data
        let targetDay = monthData.first { $0.gregorianDay == 3 }
        XCTAssertNotNil(targetDay, "Should find day 3 in January 1953")
        XCTAssertEqual(targetDay?.tibetanDay, "十八")
    }
    
    func testYearDataRetrieval() {
        // Test getting entire year data
        let yearData = provider.getYearData(year: 1953)
        XCTAssertFalse(yearData.isEmpty, "1953 should have data")
        
        // Find the specific day in the year data
        let targetDay = yearData.first { $0.gregorianMonth == 1 && $0.gregorianDay == 3 }
        XCTAssertNotNil(targetDay, "Should find 1953-01-03 in year data")
        XCTAssertEqual(targetDay?.tibetanYear, "水龙")
    }
    
    func testAvailableYears() {
        // Test available years range
        let years = provider.availableYears
        XCTAssertEqual(years.lowerBound, 1952, "Available years should start at 1952")
        XCTAssertEqual(years.upperBound, 2050, "Available years should end at 2050")
        XCTAssertTrue(years.contains(1953), "1953 should be in available years")
    }
    
    func testCacheBehavior() {
        // Test that data is cached after first access
        _ = provider.getDayData(year: 1953, month: 1, day: 3)
        
        // Clear cache and verify data is still accessible (should reload from file)
        provider.clearCache()
        let dayData = provider.getDayData(year: 1953, month: 1, day: 3)
        XCTAssertNotNil(dayData, "Should be able to reload data after clearing cache")
        XCTAssertEqual(dayData?.tibetanYear, "水龙")
    }
    
    func testInvalidDate() {
        // Test with invalid date
        let dayData = provider.getDayData(year: 1900, month: 1, day: 1)
        XCTAssertNil(dayData, "Should return nil for invalid year")
        
        let dayData2 = provider.getDayData(year: 1953, month: 13, day: 1)
        XCTAssertNil(dayData2, "Should return nil for invalid month")
        
        let dayData3 = provider.getDayData(year: 1953, month: 1, day: 32)
        XCTAssertNil(dayData3, "Should return nil for invalid day")
    }
}
