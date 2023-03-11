//
//  ContentView.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: Internal

    var body: some View {
        #if os(macOS)
            NavigationView {
                VStack(alignment: .leading) {
                    List {
                        NavigationLink(destination: ChatView(), tag: 0, selection: $selected) {
                            Label("Chat", systemImage: "bubble.left.and.bubble.right")
                        }
                        
                        NavigationLink(destination: WritingView(), tag: 1, selection: $selected) {
                            Label("Write", systemImage: "square.and.pencil")
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
        #else
            TabView {
                ChatView()
                    .tabItem {
                        Label("Chat", systemImage: "bubble.left.and.bubble.right")
                    }
                
                WritingView()
                    .tabItem {
                        Label("Write", systemImage: "square.and.pencil")
                    }
            }
        #endif
    }

    // MARK: Private

    @State private var selected: Int? = 0
}
