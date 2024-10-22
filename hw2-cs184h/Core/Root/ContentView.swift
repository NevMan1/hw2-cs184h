//
//  ContentView.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                ProfileView()
            }
            else{
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
