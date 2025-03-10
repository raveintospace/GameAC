//
//  ContentView.swift
//  SpaceBattleGameAC
//
//  Created by Uri on 8/3/25.
//

import SwiftUI
import SpriteKit

enum GameState {
    case game, menu
}

struct ContentView: View {
    
    @State private var state: GameState = .menu
    
    var body: some View {
        ZStack {
            menu
        }
        .statusBarHidden()
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    
    private var menu: some View {
        ZStack {
            Image(.bkgd0)
                .resizable()
            Button {
                
            } label: {
                Text("Start")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .ignoresSafeArea()
        .scaledToFill()
    }
}
