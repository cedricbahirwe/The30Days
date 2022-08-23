//
//  ContentView.swift
//  The30Days
//
//  Created by Cédric Bahirwe on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    static let finalID: Int = 30
    @StateObject private var store = AppStore()
    @State private var showDatePicker = false
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 10) {
                    Text("The30DaysApp")
                        .font(.system(.largeTitle, design: .monospaced))
                        .fontWeight(.black)


                    Group {
                        if store.lastAchievementID == ContentView.finalID {
                            Text("Congratulations!!!, You have done it!")
                        } else {
                            let remaining = ContentView.finalID-store.lastAchievementID
                            Text("Just \(remaining) more day \(remaining>1 ? "s" : "") to go 💪🏼!")
                        }
                    }
                    .font(.system(.title, design: .rounded).bold())
                }
                .padding(.bottom, 10)

                VStack {
                    ForEach(store.getMatrix(), id:\.self) { matrixRow in
                        HStack {
                            ForEach(matrixRow, id:\.self) { item in
                                Image(systemName: item <= store.lastAchievementID ? "checkmark.circle.fill" : "checkmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(item <= store.lastAchievementID ? .green : .primary)
                                    .onTapGesture {
                                        store.setAchievement(item)
                                    }
                            }
                        }
                    }
                }
                .padding(10)
                .frame(maxHeight: .infinity)
            }
            .safeAreaInset(edge: .bottom) {
                Text("\(store.counter) seconds remaining")
                    .font(.system(.title3, design: .monospaced).bold())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThickMaterial)
                    .foregroundColor(.blue)

            }
            .safeAreaInset(edge: .top) {
                HStack {
                    Spacer()
                    Button {
                        showDatePicker.toggle()
                    } label: {
                        Label("Edit Start Date", systemImage: "calendar")
                            .imageScale(.large)
                            .labelStyle(.iconOnly)

                    }
                    .padding()
                }
            }
            .onReceive(store.countDownTimer) { _ in
                store.startCountDown()
            }

            if showDatePicker {
                DatePicker("Change Start Date",
                           selection: $store.selectedStartDate,
                           displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .background(.ultraThickMaterial)
                    .cornerRadius(15)
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        EmptyView()
                            .background(.ultraThinMaterial)
                            .onTapGesture {
                                showDatePicker.toggle()
                            }
                    )
                    .onChange(of: store.selectedStartDate, perform: store.handleStartDateChange)
            }
        }
//        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
