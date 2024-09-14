//
//  ContentView.swift
//  OpenTok
//
//  Created by Kyle Johnson on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
            HowToListView()
            FooterView()
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Image("AppIcon-Rounded")
                    .resizable()
                    .frame(width: 96, height: 96)
                    .padding()
                VStack(alignment: .leading) {
                    HStack {
                        Text("Tok Unblock")
                            .font(.title)
                            .bold()
                    }
                    Text("A Safari extension that lets you watch shared TikToks in your browser")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(.secondary)
                }
                .padding(.trailing)
                .padding(.vertical)
            }
        }
        .padding(.top, 24)
    }
}

struct HowToListView: View {
    var body: some View {
        List {
            Section {
                ListEntry(
                    Text("Open the **Settings** app"),
                    image: "gear",
                    color: .gray
                )
                ListEntry(
                    Text("Select **Safari**"),
                    image: "safari",
                    color: .blue
                )
                ListEntry(
                    Text("Select **Extensions**"),
                    image: "puzzlepiece.extension",
                    color: .purple
                )
                ListEntry(
                    Text("Select **Tok Unblock**"),
                    image: "bolt.horizontal",
                    color: .pink
                )
                ListEntry(
                    Text("Turn on **Allow Extension**"),
                    image: "switch.2",
                    color: .green
                )
                ListEntry(
                    Text("Change tiktok.com to **Allow**"),
                    image: "checkmark.circle",
                    color: .blue
                )
            } header: {
                Text("\nHow to Enable")
            }
            Section {
                HStack(spacing: 24) {
                    Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                        ListEntry(
                            Text("Open Settings"),
                            image: "gear",
                            color: .white
                        )
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    
                    Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                        ListEntry(
                            Text("Test Video Link"),
                            image: "music.note",
                            color: .white
                        )
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                }
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.top, -10)
        }
        .scrollDisabled(true)
    }
    
    struct ListEntry: View {
        let text: Text
        let image: String
        let color: Color
        
        init(_ text: Text, image: String, color: Color) {
            self.text = text
            self.image = image
            self.color = color
        }
        
        var body: some View {
            Label {
                text
                    .multilineTextAlignment(.leading)
            } icon: {
                Image(systemName: image)
                    .foregroundStyle(color)
            }
        }
    }
}

struct FooterView: View {
    var body: some View {
        Text("© 2024 Kyle Johnson Apps")
            .font(.footnote)
            .bold()
            .foregroundStyle(.secondary)
            .padding(8)
    }
}

#Preview {
    ContentView()
}
