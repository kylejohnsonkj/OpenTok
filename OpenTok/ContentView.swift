//
//  ContentView.swift
//  OpenTok
//
//  Created by Kyle Johnson on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            HeaderView()
            HowToListView()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [
                .background,
                .background,
                .groupTableViewBackground,
                .groupTableViewBackground
            ]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("AppIcon-Rounded")
                .resizable()
                .frame(width: 96, height: 96)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text("OpenTok")
                    .font(.title)
                    .bold()
                Text("A Safari extension that lets you watch shared TikToks in your browser")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

struct HowToListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("How to enable")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .padding(.top)
            
            ListEntry(
                Text("Open a shared TikTok video"),
                image: "1.circle"
            )
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            ListButton(
                text: "Try it now!",
                image: "music.note",
                link: "https://www.tiktok.com/t/ZP8eVDC8c/"
            )
            .tint(.pink)
            .padding(.leading, 35)
            
            Group {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    if #available(iOS 18, *) {
                        ListEntry(
                            Text("Tap the \(Image("symbol")) icon on the left of the search bar"),
                            image: "2.circle"
                        )
                    } else {
                        ListEntry(
                            Text("Tap the \(Image(systemName: "textformat.size")) icon on the left of the search bar"),
                            image: "2.circle"
                        )
                    }
                } else {
                    ListEntry(
                        Text("Tap the \(Image(systemName: "puzzlepiece.extension")) icon on the right of the search bar"),
                        image: "2.circle"
                    )
                }
            }
            .padding(.vertical)
            
            ListEntry(
                Text("Enable and allow the extension for TikTok.com"),
                image: "3.circle"
            )
            
            VideoExplainerSwiftUIView()
                .aspectRatio(1, contentMode: .fit)
                .shadow(radius: 3)
                .padding(.vertical)
                .padding(.horizontal, 2)
            
            ListEntry(
                Text("TikToks still not playing?"),
                image: "questionmark.circle"
            )
            .padding(.bottom, 8)
            
            ListButton(
                text: "Verify setup",
                image: "gear"
            )
            .tint(.darkGray)
            .padding(.leading, 35)
            .padding(.bottom)
        }
        .padding(.horizontal)
        .background(.groupTableViewBackground)
    }
    
    struct ListEntry: View {
        let text: Text
        let image: String
        
        init(_ text: Text, image: String) {
            self.text = text
            self.image = image
        }
        
        var body: some View {
            Label {
                text
                    .font(.headline)
                    .imageScale(.large)
            } icon: {
                Image(systemName: image)
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    ContentView()
}
