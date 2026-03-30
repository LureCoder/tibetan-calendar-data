import Foundation

/// 每日藏历数据模型
/// Daily Tibetan calendar data model
public struct DayData: Codable, Sendable {
    /// 公历年
    /// Gregorian year
    public let gregorianYear: Int
    
    /// 公历月
    /// Gregorian month
    public let gregorianMonth: Int
    
    /// 公历日
    /// Gregorian day
    public let gregorianDay: Int
    
    /// 星期几（0-6）
    /// Weekday (0-6)
    public let weekday: Int
    
    /// 藏历年（如"水兔"）
    /// Tibetan year (e.g., "水兔")
    public let tibetanYear: String
    
    /// 藏历年元素（如"水"）
    /// Tibetan year element (e.g., "水")
    public let tibetanYearElement: String
    
    /// 藏历年生肖（如"兔"）
    /// Tibetan year animal (e.g., "兔")
    public let tibetanYearAnimal: String
    
    /// 藏历月（如"十一"）
    /// Tibetan month (e.g., "十一")
    public let tibetanMonth: String
    
    /// 藏历月份名称（如"庄严月"）
    /// Tibetan month name (e.g., "庄严月")
    public let tibetanMonthName: String
    
    /// 藏历日（如"十八"）
    /// Tibetan day (e.g., "十八")
    public let tibetanDay: String
    
    /// 是否闰日
    /// Whether it's a leap day
    public let isLeapDay: Bool
    
    /// 是否月初
    /// Whether it's the start of a month
    public let isMonthStart: Bool
    
    /// 是否年初
    /// Whether it's the start of a year
    public let isYearStart: Bool
    
    /// 节日名称
    /// Festival name
    public let festival: String
    
    /// 特殊备注
    /// Special note
    public let specialNote: String
    
    /// 是否日食
    /// Whether there's a solar eclipse
    public let solarEclipse: Bool
    
    /// 是否月食
    /// Whether there's a lunar eclipse
    public let lunarEclipse: Bool
    
    /// 日食月食详情
    /// Eclipse details
    public let eclipseDetail: String

    enum CodingKeys: String, CodingKey {
        case gregorianYear = "gregorian_year"
        case gregorianMonth = "gregorian_month"
        case gregorianDay = "gregorian_day"
        case weekday
        case tibetanYear = "tibetan_year"
        case tibetanYearElement = "tibetan_year_element"
        case tibetanYearAnimal = "tibetan_year_animal"
        case tibetanMonth = "tibetan_month"
        case tibetanMonthName = "tibetan_month_name"
        case tibetanDay = "tibetan_day"
        case isLeapDay = "is_leap_day"
        case isMonthStart = "is_month_start"
        case isYearStart = "is_year_start"
        case festival
        case specialNote = "special_note"
        case solarEclipse = "solar_eclipse"
        case lunarEclipse = "lunar_eclipse"
        case eclipseDetail = "eclipse_detail"
    }
}
