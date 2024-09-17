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
                        Text("OpenTok")
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
        .padding(.top)
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
                if #available(iOS 18, *) {
                    ListEntry(
                        Text("Select **Apps**"),
                        image: "square.grid.3x3",
                        color: .purple
                    )
                }
                ListEntry(
                    Text("Select **Safari**"),
                    image: "safari",
                    color: .blue
                )
                ListEntry(
                    Text("Select **Extensions**"),
                    image: "puzzlepiece.extension",
                    color: .gray
                )
                ListEntry(
                    Text("Select **OpenTok**"),
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
            
            HowToButtonView()
        }
        .scrollBounceBehavior(.basedOnSize)
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

struct HowToButtonView: View {
    var body: some View {
        HStack(spacing: 12) {
            ButtonView(
                text: "Open Settings",
                image: "gear",
                link: UIApplication.openSettingsURLString
            )
            .foregroundStyle(.settingsText)
            .tint(Color.settingsBackground)
            
            ButtonView(
                text: "Test Video",
                image: "music.note",
                link: UIApplication.openSettingsURLString
            )
            .tint(.pink)
        }
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .padding(.top, -4)
    }
    
    struct ButtonView: View {
        let text: String
        let image: String
        let link: String
        
        var body: some View {
            Link(destination: URL(string: link)!) {
                HStack {
                    Image(systemName: image)
                        .imageScale(.large)
                    Text(text)
                }
            }
            .buttonStyle(.borderedProminent)
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
