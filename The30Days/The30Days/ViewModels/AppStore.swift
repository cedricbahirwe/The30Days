//
//  AppStore.swift
//  The30Days
//
//  Created by Cédric Bahirwe on 23/08/2022.
//

import Foundation

final class AppStore: ObservableObject {
    private let localStore: LocalStore

    @Published private(set) var lastAchievementID: Int
    @Published private(set) var counter: Int

    @Published var selectedStartDate: Date

    let countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let matrix = Matrix(6, 5)


    init() {
        self.localStore = LocalStore()
        self.selectedStartDate = localStore.getStartDate()
        let id = localStore.getLastAchievementID()
        self.lastAchievementID = id
        self.counter = Int(localStore.getRemainingInterval(id ))
    }

    func getMatrix() -> [[Int]] {
        matrix.getMatrixTable()
    }

    func setAchievement(_ index: Int) {
        lastAchievementID = index
        localStore.saveLastAchievement(index)
        counter = Int(localStore.getRemainingInterval(lastAchievementID))
    }

    func clearStorage(){
        localStore.clearStorage()
        self.lastAchievementID = LocalStore.defaultAchievement
    }

    func startCountDown() {
        guard counter != 0 else { return }
        counter -= 1
    }

    func handleStartDateChange(_ date: Date) {
        localStore.saveStartDate(date)
        selectedStartDate = date
        lastAchievementID = localStore.getLastAchievementID()
        counter = Int(localStore.getRemainingInterval(lastAchievementID))
    }
}
