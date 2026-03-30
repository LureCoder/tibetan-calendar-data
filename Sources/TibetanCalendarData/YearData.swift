import Foundation

struct MonthData: Codable {
    let month: Int
    let days: [DayData]
}

struct YearData: Codable {
    let year: Int
    let months: [MonthData]
}
