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
        .background(Color.background)
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
                    color: .orange
                )
            } header: {
                Text("\nHow to Enable")
            }
            
            HStack {
                Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                    HStack {
                        Image(systemName: "gear")
                            .imageScale(.large)
                        Text("Open Settings")
                    }
                    .foregroundStyle(.settingsText)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.settingsBackground)
                
                Spacer()
                
                Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                    HStack {
                        Image(systemName: "music.note")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                        Text("Test Video")
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.top, -4)
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
            .padding(.top, 4)
            .padding(.bottom, 12)
    }
}

#Preview {
    ContentView()
}
