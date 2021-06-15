//
//  AnimalsApp.swift
//  Animals
//
//  Created by Taha Çekin on 15.06.2021.
//

import SwiftUI

@main
struct AnimalsApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(viewModel: AnimalViewModel())
        }
    }
}
