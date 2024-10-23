//
//  hw2_cs184hApp.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//


import SwiftUI
import Firebase
@main
struct hw2_cs184hApp: App {
    @StateObject var viewModel = AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
