import Foundation

public final class TibetanCalendarDataProvider: @unchecked Sendable {
    public static let shared = TibetanCalendarDataProvider()
    
    private var yearDataCache: [Int: YearData] = [:]
    private let cacheLock = NSLock()
    
    public init() {}
    
    public func getDayData(year: Int, month: Int, day: Int) -> DayData? {
        guard let yearData = loadYearData(year: year) else {
            return nil
        }
        
        for monthData in yearData.months {
            if monthData.month == month {
                for dayData in monthData.days {
                    if dayData.gregorianDay == day {
                        return dayData
                    }
                }
            }
        }
        
        return nil
    }
    
    public func getDayData(date: Date) -> DayData? {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return getDayData(year: year, month: month, day: day)
    }
    
    public func getMonthData(year: Int, month: Int) -> [DayData] {
        guard let yearData = loadYearData(year: year) else {
            return []
        }
        
        for monthData in yearData.months {
            if monthData.month == month {
                return monthData.days
            }
        }
        
        return []
    }
    
    public func getYearData(year: Int) -> [DayData] {
        guard let yearData = loadYearData(year: year) else {
            return []
        }
        
        return yearData.months.flatMap { $0.days }
    }
    
    public var availableYears: ClosedRange<Int> {
        return 1952...2050
    }
    
    public func preloadYear(_ year: Int) {
        _ = loadYearData(year: year)
    }
    
    public func preloadAllYears() {
        for year in availableYears {
            preloadYear(year)
        }
    }
    
    public func clearCache() {
        cacheLock.lock()
        defer { cacheLock.unlock() }
        yearDataCache.removeAll()
    }
    
    private func loadYearData(year: Int) -> YearData? {
        cacheLock.lock()
        defer { cacheLock.unlock() }
        
        if let cached = yearDataCache[year] {
            return cached
        }
        
        guard let url = Bundle.module.url(forResource: "\(year)", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let yearData = try? decoder.decode(YearData.self, from: data) else {
            return nil
        }
        
        yearDataCache[year] = yearData
        return yearData
    }
}
