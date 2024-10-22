//
//  LoginView.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//

import SwiftUI
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View{
        NavigationStack{
            VStack{
                
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address",
                              placeholder: "name@example.com")
                    
                    InputView(text: $password, title: "Password",
                              placeholder: "enter here",
                              isSecureField: true)
                }
                
                Button {
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                    
                    print("Log user in..")
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                    
                    }
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                NavigationLink{
                    RegistrationView()
                } label: {
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign up")
                    }
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View{
        LoginView()
    }
}
