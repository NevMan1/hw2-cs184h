//
//  RegistrationView.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            VStack(spacing: 24){
                InputView(text: $email, title: "Email Address",
                          placeholder: "name@example.com")
                
                InputView(text: $fullname, title: "Full Name",
                          placeholder: "Enter your name")
                
                InputView(text: $password, title: "Password",
                          placeholder: "enter here",
                          isSecureField: true)
            }
        }
        Button {
            Task{
                try await viewModel.createUser(withEmail: email,
                                               password:password,
                                               fullname: fullname)
            }
            print("Sign user up..")
        } label: {
            HStack {
                Text("SIGN UP")
                    .fontWeight(.semibold)
            
            }
        }
        .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
        Spacer()
    }
}
extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5 && !fullname.isEmpty
    }
}
