//
//  LocalStorage.swift
//  The30Days
//
//  Created by Cédric Bahirwe on 23/08/2022.
//

import Foundation

final class LocalStore {
    private let defaults = UserDefaults()
    private let defaultChallengeDays: Int = 30
    private let epochDayInterval: Int = 86_400

    enum LocalKeys {
        static let startDate = "startDate"
    }

    func saveStartDate(_ date: Date) {
        defaults.setValue(date, forKey: LocalKeys.startDate)
    }

    func getStartDate() -> Date {
        defaults.value(forKey: LocalKeys.startDate) as? Date ?? Date()
    }


    private func getLongInterval() -> TimeInterval {
        let maxChallengeInterval = TimeInterval(defaultChallengeDays * epochDayInterval)
        let endDate = getStartDate().addingTimeInterval(maxChallengeInterval)

        return endDate.timeIntervalSinceNow - Date().timeIntervalSinceNow
    }

    func getRemainingInterval() -> Int {
        Int(getLongInterval())
    }

    func getCompletedDayID() -> Int {
        let difference = Double(getRemainingInterval()) / Double(epochDayInterval)
        return defaultChallengeDays - Int(ceil(difference))
    }

    func clearStorage() {
        defaults.removeObject(forKey: LocalKeys.startDate)
    }
}
