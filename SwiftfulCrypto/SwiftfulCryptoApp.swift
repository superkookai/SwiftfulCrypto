//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Weerawut Chaiyasomboon on 6/12/2566 BE.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
