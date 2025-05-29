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
    
    private let gameOver = NotificationCenter.default.publisher(for: .gameover)
    @State private var state: GameState = .menu
    
    var body: some View {
        ZStack {
            switch state {
            case .game:
                SpriteView(scene: GameScene.newGame)
            case .menu:
                menu
            }
        }
        .onReceive(gameOver) { _ in
            Task {
                try await Task.sleep(for: .seconds(2))
                state = .menu
            }
        }
        .animation(.default, value: state)
        .statusBarHidden()
        .ignoresSafeArea()
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
                state = .game
            } label: {
                Text("Start")
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
    }
}
