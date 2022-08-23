//
//  LocalStorage.swift
//  The30Days
//
//  Created by Cédric Bahirwe on 23/08/2022.
//

import Foundation

final class LocalStore: UserDefaults {
    static let defaultAchievement = 1
    enum LocalKeys {
        static let startDate = "startDate"
        static let achievementID = "achievementID"
    }

    func saveLastAchievement(_ id: Int) {
        setValue(id, forKey: LocalKeys.achievementID)
    }

    func getLastAchievementID() -> Int {
        value(forKey: LocalKeys.achievementID) as? Int ?? LocalStore.defaultAchievement
    }

    func getStartDate() -> Date {
        value(forKey: LocalKeys.startDate) as? Date ?? Date()
    }

    func saveStartDate(_ date: Date) {
        setValue(date, forKey: LocalKeys.startDate)
    }

    func clearStorage() {
        removeObject(forKey: LocalKeys.startDate)
        removeObject(forKey: LocalKeys.achievementID)
    }

    func getRemainingInterval(_ id: Int) -> TimeInterval {
        let startDate = getStartDate()
        let spendDate = startDate.addingTimeInterval(TimeInterval(id * 86_400))
        let endDate = startDate.addingTimeInterval(30 * 86_400)

        return endDate.timeIntervalSinceNow - spendDate.timeIntervalSinceNow
    }
}
