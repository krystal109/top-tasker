//
//  ContentView.swift
//  Top Tasker
//
//  Created by krystal mishiev on 6/14/25.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "home"

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                if selectedTab == "home" {
                    HomeView()
                } else {
                    ProfileView()
                }
            }

            // Floating buttons (only show on home)
            if selectedTab == "home" {
                VStack {
                    HStack {
                        GradientIconButton(systemName: "chevron.left")
                        Spacer()
                        GradientIconButton(systemName: "plus")
                        Spacer()
                        GradientIconButton(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 40)

                    Spacer().frame(height: 62)
                }
            }

            // Custom Tab Bar
            HStack {
                Spacer()

                Button(action: { selectedTab = "home" }) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 42, height: 42)
                        .padding(.top, 20)
                        .foregroundColor(selectedTab == "home" ? .yellow : .gray)
                }

                Spacer()

                Button(action: { selectedTab = "profile" }) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.top, 20)
                        .foregroundColor(selectedTab == "profile" ? .yellow : .gray)
                }

                Spacer()
            }
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 4, y: -1)
                    .ignoresSafeArea(edges: .bottom)
            )
        }
    }
}

struct HomeView: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    let currentDay = "Thu"

    let leaderboard = [
        ("Emily", 92),
        ("Jacob", 87),
        ("Sophia", 84),
        ("Olivia", 76)
    ]

    let tasks = [
        ("Math homework", "8:00 AM", false, false),
        ("Biology quiz", "2:00 PM", false, false),
        ("Read chapter 5", "11:59 PM", true, false),
        ("English essay", "9:00 AM", false, true),
        ("Science project", "4:00 PM", false, false),
        ("Study for chem test", "6:00 PM", false, false),
        ("Group presentation", "8:00 PM", false, false)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Fixed Leaderboard
            HStack(spacing: 0) {
                ForEach(Array(leaderboard.enumerated()), id: \.offset) { index, person in
                    VStack(spacing: 4) {
                        Text("\(ordinal(index + 1))")
                            .font(.headline)
                            .bold()
                        Text(person.0)
                            .font(.subheadline)
                        Text("\(person.1)%")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
                }
            }
            .padding(.horizontal, 20)

            Divider().padding(.vertical, 12)

            // Planner header
            VStack(alignment: .leading, spacing: 8) {
                Text("Planner")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)

                HStack(spacing: 0) {
                    ForEach(days, id: \.self) { day in
                        ZStack {
                            if day == currentDay {
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 38, height: 38)
                            }
                            Text(day)
                                .fontWeight(day == currentDay ? .bold : .regular)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }

            // Tasks
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 12) {
                    ForEach(tasks, id: \.0) { task in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.0)
                                    .foregroundColor(task.2 ? .gray : (task.3 ? .red : .black))
                                    .strikethrough(task.2)
                                Text(task.1)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(task.3 ? Color.red : Color.black.opacity(0.1), lineWidth: 1)
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 160)
            }
        }
    }

    func ordinal(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)th"
    }
}

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 32) {
            // Name
            Text("Olivia")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 60)

            // Buttons
            VStack(spacing: 20) {
                ProfileActionButton(title: "View Group (4)")
                ProfileActionButton(title: "Account Info")
                ProfileActionButton(title: "Log Out")
            }

            Spacer()
        }
        .padding(.horizontal, 40)
    }
}

struct ProfileActionButton: View {
    let title: String

    var body: some View {
        Button(action: {
            // Action placeholder
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [Color.yellow, Color.orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
        }
    }
}

struct GradientIconButton: View {
    var systemName: String

    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: [Color.yellow, Color.orange],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 52, height: 52)
            Image(systemName: systemName)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

#Preview {
    ContentView()
}
