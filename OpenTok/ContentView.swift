//
//  ContentView.swift
//  OpenTok
//
//  Created by Kyle Johnson on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    @State var isSheetPresented = false
    
    var body: some View {
        ScrollView {
            HeaderView()
            HowToVideoView()
//            FooterView()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color.background,
                Color.background,
                Color(UIColor.groupTableViewBackground),
                Color(UIColor.groupTableViewBackground)
            ]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct HowToVideoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("How to enable")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .padding(.top)
                
                Label {
                    Text("Open a shared TikTok video")
                        .font(.headline)
                } icon: {
                    Image(systemName: "1.circle")
                        .imageScale(.large)
                }
                .padding(.top, 12)
                .padding(.bottom, 8)
                
                ButtonView(
                    text: "Try it now!",
                    image: "music.note",
                    link: "https://www.tiktok.com/t/ZP8eVDC8c/"
                )
                .tint(.pink)
                .padding(.leading, 35)
                
                Label {
                    Text("Tap the \(Image(systemName: "list.bullet.below.rectangle")) icon on the left of the URL bar")
                        .font(.headline)
                } icon: {
                    Image(systemName: "2.circle")
                        .imageScale(.large)
                }
                .padding(.vertical)
                
                Label {
                    Text("Enable and allow the extension for TikTok.com")
                        .font(.headline)
                } icon: {
                    Image(systemName: "3.circle")
                        .imageScale(.large)
                }
                
                VideoExplainerSwiftUIView()
                    .aspectRatio(886 / 1172, contentMode: .fit)
                    .shadow(radius: 3)
                    .padding(.vertical)
                
                Label {
                    Text("TikToks still not playing?")
                        .font(.headline)
                } icon: {
                    Image(systemName: "questionmark.circle")
                        .imageScale(.large)
                }
                .padding(.bottom, 8)
                
                InternalButtonView(
                    text: "Verify setup",
                    image: "gear"
                )
                .tint(Color(UIColor.darkGray))
                .padding(.leading, 35)
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .background(Color(UIColor.groupTableViewBackground))
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
                Text("\nVerify setup")
            }
            
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
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
                text: "Test Video",
                image: "music.note",
                link: "https://www.tiktok.com/t/ZP8eVDC8c/"
            )
            .tint(.pink)
        }
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .padding(.top, -4)
    }
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

struct InternalButtonView: View {
    let text: String
    let image: String
    
    @State var isSheetPresented = false
    
    var body: some View {
        Button {
            isSheetPresented = true
        } label: {
            HStack {
                Image(systemName: image)
                    .imageScale(.large)
                Text(text)
            }
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isSheetPresented) {
            HowToListView()
        }
    }
}

struct FooterView: View {
    var body: some View {
        Text("© 2024 Kyle Johnson Apps")
            .font(.footnote)
            .bold()
            .foregroundStyle(.secondary)
            .padding(.top)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
            .background(Color.background)
    }
}

#Preview {
    ContentView()
}
