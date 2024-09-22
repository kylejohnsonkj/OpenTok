//
//  ListButton.swift
//  OpenTok
//
//  Created by Kyle Johnson on 9/21/24.
//

import SwiftUI

struct ListButton: View {
    let text: String
    let image: String
    let link: String?
    
    init(text: String, image: String, link: String? = nil) {
        self.text = text
        self.image = image
        self.link = link
    }
    
    @State var isSheetPresented = false
    
    var body: some View {
        Group {
            if let link {
                Link(destination: URL(string: link)!) {
                    HStack {
                        Image(systemName: image)
                            .imageScale(.large)
                        Text(text)
                    }
                }
            } else {
                Button {
                    isSheetPresented = true
                } label: {
                    HStack {
                        Image(systemName: image)
                            .imageScale(.large)
                        Text(text)
                    }
                }
                .sheet(isPresented: $isSheetPresented) {
                    VerifySetupListView()
                }
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ContentView()
}
