import Foundation

/// 藏历数据提供者
/// Tibetan calendar data provider
public final class TibetanCalendarDataProvider: @unchecked Sendable {
    /// 单例实例
    /// Shared instance
    public static let shared = TibetanCalendarDataProvider()
    
    /// 年份数据缓存
    /// Year data cache
    private var yearDataCache: [Int: YearData] = [:]
    
    /// 缓存锁（线程安全）
    /// Cache lock (thread-safe)
    private let cacheLock = NSLock()
    
    /// 初始化方法
    /// Initializer
    public init() {}
    
    /// 通过公历年月日获取单日藏历数据
    /// Get daily Tibetan calendar data by Gregorian date
    /// - Parameters:
    ///   - year: 公历年
    ///   - month: 公历月
    ///   - day: 公历日
    /// - Returns: 单日藏历数据，如果找不到则返回 nil
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
    
    /// 通过 Date 对象获取单日藏历数据
    /// Get daily Tibetan calendar data by Date object
    /// - Parameter date: Date 对象
    /// - Returns: 单日藏历数据，如果找不到则返回 nil
    public func getDayData(date: Date) -> DayData? {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return getDayData(year: year, month: month, day: day)
    }
    
    /// 获取整月藏历数据
    /// Get monthly Tibetan calendar data
    /// - Parameters:
    ///   - year: 公历年
    ///   - month: 公历月
    /// - Returns: 该月所有日期的藏历数据数组
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
    
    /// 获取整年藏历数据
    /// Get yearly Tibetan calendar data
    /// - Parameter year: 公历年
    /// - Returns: 该年所有日期的藏历数据数组
    public func getYearData(year: Int) -> [DayData] {
        guard let yearData = loadYearData(year: year) else {
            return []
        }
        
        return yearData.months.flatMap { $0.days }
    }
    
    /// 可用年份范围
    /// Available years range
    public var availableYears: ClosedRange<Int> {
        return 1952...2050
    }
    
    /// 预加载指定年份数据到缓存
    /// Preload data for a specific year into cache
    /// - Parameter year: 年份
    public func preloadYear(_ year: Int) {
        _ = loadYearData(year: year)
    }
    
    /// 预加载所有年份数据到缓存
    /// Preload data for all years into cache
    public func preloadAllYears() {
        for year in availableYears {
            preloadYear(year)
        }
    }
    
    /// 清除缓存
    /// Clear cache
    public func clearCache() {
        cacheLock.lock()
        defer { cacheLock.unlock() }
        yearDataCache.removeAll()
    }
    
    /// 加载年份数据
    /// Load year data
    /// - Parameter year: 年份
    /// - Returns: 年份数据，如果加载失败则返回 nil
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
