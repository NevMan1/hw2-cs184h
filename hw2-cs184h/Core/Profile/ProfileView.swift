//
//  ProfileView.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            if let user = viewModel.currentUser {
                List {
                    Section {
                        VStack{
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                    Section("General") {
                        // Navigation link to another view (e.g. SettingsView)
                        NavigationLink(destination: SettingsView()) {
                            Text("Settings")
                        }
                    }
                    Section("Account") {
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            Text("Sign out")
                        }
                    }
                }
                .navigationTitle("Profile") // Set the navigation bar title
            }
        }
    }
}

// Example of a destination view for navigation
struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .navigationTitle("Settings")
    }
}
