# TibetanCalendarData

一个 Swift Package，提供 1952-2050 年的藏历数据，支持通过公历年月日获取每日的藏历信息。

## 功能特点

- 📅 支持 1952-2050 年的完整藏历数据
- 🔍 通过公历年月日快速查询藏历信息
- 🎯 提供详细的藏历字段，包括：
  - 藏历年月日
  - 藏历月份名称
  - 藏历年份元素和生肖
  - 节日信息
  - 特殊备注
  - 日食月食信息
- ⚡ 懒加载 + 缓存机制，提高性能
- 📱 支持 iOS 13+ 和 macOS 11+

## 安装

### Swift Package Manager

在 Xcode 中：
1. 选择 File > Add Package Dependencies...
2. 输入 URL：`https://github.com/yourusername/tibetan-calendar-data.git`
3. 选择版本并添加到你的项目

### 手动安装

将 `TibetanCalendarData` 目录复制到你的项目中，然后在 Xcode 中添加为依赖。

## 使用方法

### 基本用法

```swift
import TibetanCalendarData

// 获取数据提供者单例
let provider = TibetanCalendarDataProvider.shared

// 方法 1：通过年月日获取
if let dayData = provider.getDayData(year: 2024, month: 1, day: 15) {
    print("公历：\(dayData.gregorianYear)-\(dayData.gregorianMonth)-\(dayData.gregorianDay)")
    print("藏历：\(dayData.tibetanYear)年 \(dayData.tibetanMonth)月 \(dayData.tibetanDay)")
    print("月份名称：\(dayData.tibetanMonthName)")
    print("节日：\(dayData.festival)")
    print("特殊备注：\(dayData.specialNote)")
}

// 方法 2：通过 Date 对象获取
if let dayData = provider.getDayData(date: Date()) {
    print("今天的藏历：\(dayData.tibetanYear)年 \(dayData.tibetanMonth)月 \(dayData.tibetanDay)")
}
```

### 获取整月数据

```swift
// 获取 2024 年 1 月的所有数据
let januaryData = provider.getMonthData(year: 2024, month: 1)
for dayData in januaryData {
    print("\(dayData.gregorianDay)日: \(dayData.tibetanDay)")
}
```

### 获取整年数据

```swift
// 获取 2024 年的所有数据
let yearData = provider.getYearData(year: 2024)
print("2024年共有 \(yearData.count) 天的藏历数据")
```

### 预加载数据

```swift
// 预加载特定年份数据
provider.preloadYear(2024)

// 预加载所有年份数据（建议在应用启动时执行）
provider.preloadAllYears()

// 清除缓存
provider.clearCache()
```

## 数据结构

### DayData

| 字段 | 类型 | 说明 |
|------|------|------|
| `gregorianYear` | Int | 公历年 |
| `gregorianMonth` | Int | 公历月 |
| `gregorianDay` | Int | 公历日 |
| `weekday` | Int | 星期几（0-6） |
| `tibetanYear` | String | 藏历年（如"水兔"） |
| `tibetanYearElement` | String | 藏历年元素（如"水"） |
| `tibetanYearAnimal` | String | 藏历年生肖（如"兔"） |
| `tibetanMonth` | String | 藏历月（如"十一"） |
| `tibetanMonthName` | String | 藏历月份名称（如"庄严月"） |
| `tibetanDay` | String | 藏历日（如"十八"） |
| `isLeapDay` | Bool | 是否闰日 |
| `isMonthStart` | Bool | 是否月初 |
| `isYearStart` | Bool | 是否年初 |
| `festival` | String | 节日名称 |
| `specialNote` | String | 特殊备注 |
| `solarEclipse` | Bool | 是否日食 |
| `lunarEclipse` | Bool | 是否月食 |
| `eclipseDetail` | String | 日食月食详情 |

## API 参考

### TibetanCalendarDataProvider

#### 主要方法

- **`getDayData(year: Int, month: Int, day: Int) -> DayData?`**
  通过公历年月日获取单日藏历数据

- **`getDayData(date: Date) -> DayData?`**
  通过 Date 对象获取单日藏历数据

- **`getMonthData(year: Int, month: Int) -> [DayData]`**
  获取整月藏历数据

- **`getYearData(year: Int) -> [DayData]`**
  获取整年藏历数据

- **`availableYears: ClosedRange<Int>`**
  可用年份范围（1952...2050）

- **`preloadYear(_ year: Int)`**
  预加载指定年份数据到缓存

- **`preloadAllYears()`**
  预加载所有年份数据到缓存

- **`clearCache()`**
  清除缓存

## 性能优化

- **懒加载**：只在首次访问时加载对应年份的 JSON 文件
- **缓存机制**：使用内存缓存，避免重复加载
- **线程安全**：使用 NSLock 确保多线程访问安全

## 数据来源

数据来源于 `zangli-converter` 项目生成的 JSON 文件，包含 1952-2050 年的完整藏历信息。

## 测试

项目包含完整的单元测试，覆盖：
- 基本数据查询
- 日期对象查询
- 整月/整年数据获取
- 缓存行为
- 无效日期处理

## 系统要求

- iOS 13.0+
- macOS 11.0+
- Swift 5.9+

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！
