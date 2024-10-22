//
//  AuthViewModel.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get }
}
@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    func signIn(withEmail email: String, password: String) async throws {
        print("Sign in...")
        do {
                    let result = try await Auth.auth().signIn(withEmail: email, password: password)
                    self.userSession = result.user
                    await fetchUser()
                } catch {
                    print("Debug failed to login \(error.localizedDescription)")
                }
    }
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail:email, password:password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
        } catch {
            print("Error")
            
        }
        await fetchUser()
        print("Create user")
    }
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Error")
        }
    }
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
                
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
       self.currentUser = try? snapshot.data(as: User.self)
       print("Debug: Current user is \(self.currentUser)")
        
    }
    
}

