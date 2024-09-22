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
            HowToVideoView()
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
                    Text("Tap the \(Image("symbol")) icon on the left of the search bar")
                        .font(.headline)
                        .imageScale(.large)
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
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 3)
                    .padding(.vertical)
                    .padding(.horizontal, 2)
                
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
        .background(.groupTableViewBackground)
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

#Preview {
    ContentView()
}
