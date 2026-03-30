import Foundation

/// 月份数据模型
/// Month data model
struct MonthData: Codable {
    /// 月份
    /// Month number
    let month: Int
    
    /// 该月的所有日期数据
    /// All day data for this month
    let days: [DayData]
}

/// 年份数据模型
/// Year data model
struct YearData: Codable {
    /// 年份
    /// Year number
    let year: Int
    
    /// 该年的所有月份数据
    /// All month data for this year
    let months: [MonthData]
}
