import Foundation

public struct DayData: Codable, Sendable {
    public let gregorianYear: Int
    public let gregorianMonth: Int
    public let gregorianDay: Int
    public let weekday: Int
    public let tibetanYear: String
    public let tibetanYearElement: String
    public let tibetanYearAnimal: String
    public let tibetanMonth: String
    public let tibetanMonthName: String
    public let tibetanDay: String
    public let isLeapDay: Bool
    public let isMonthStart: Bool
    public let isYearStart: Bool
    public let festival: String
    public let specialNote: String
    public let solarEclipse: Bool
    public let lunarEclipse: Bool
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
