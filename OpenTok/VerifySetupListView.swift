//
//  VerifySetupListView.swift
//  OpenTok
//
//  Created by Kyle Johnson on 9/21/24.
//

import SwiftUI

struct VerifySetupListView: View {
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
                    color: .teal
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
            } footer: {
                Text("If the issue persists, set tiktok.com and Other Websites both to **Ask**, then rewatch the tutorial. Ensure you select **Always Allow on This Website** when prompted.")
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

#Preview {
    VerifySetupListView()
}
