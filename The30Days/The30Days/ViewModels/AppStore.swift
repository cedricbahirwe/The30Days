//
//  AppStore.swift
//  The30Days
//
//  Created by Cédric Bahirwe on 23/08/2022.
//

import Foundation
import Combine

final class AppStore: ObservableObject {
    private let localStore: LocalStore

    @Published private(set) var completedDayID: Int
    @Published private(set) var counter: Int

    @Published var selectedStartDate: Date

    private let countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let matrix = Matrix(6, 5)

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.localStore = LocalStore()
        self.selectedStartDate = localStore.getStartDate()
        let interval = localStore.getRemainingInterval()
        self.counter = interval
        self.completedDayID = localStore.getCompletedDayID()
        subscribeToCounterUpdates()
    }

    private func subscribeToCounterUpdates() {
        countDownTimer.sink { [weak self] _ in
            guard let self = self else { return }
            self.counter = self.localStore.getRemainingInterval()
            self.completedDayID = self.localStore.getCompletedDayID()
        }
        .store(in: &cancellables)
    }

    func getMatrix() -> [[Int]] {
        matrix.getMatrixTable()
    }

    func clearStorage(){
        localStore.clearStorage()
    }

    func startCountDown() {
        guard counter != 0 else { fatalError() }
        counter -= 1
    }

    func handleStartDateChange(_ date: Date) {
        localStore.saveStartDate(date)
        selectedStartDate = date
    }
}
