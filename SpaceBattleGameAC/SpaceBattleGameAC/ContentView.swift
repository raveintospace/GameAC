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
        menu
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    
    private var menu: some View {
        ZStack {
            Image(.bkgd0)
            Button {
                
            } label: {
                Text("Start")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .ignoresSafeArea()
    }
}
