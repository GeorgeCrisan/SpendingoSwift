//
//  SwiftUIView.swift
//  SpendingoSwift
//
//  Created by George Crisan on 20/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    
    @Published var session: User? {didSet {self.didChange.send(self) }}
    
    var handle: AuthStateDidChangeListenerHandle?
    
    // call back
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth,user) in
            
            if let user = user {
                self.session = User(uid: user.uid, email: user.email, displayName: user.displayName)
            } else {
                self.session = nil
            }
        })
    }
    
    func updateUser (displayName: String, handler: @escaping AuthDataResultCallback) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest();
        
        changeRequest?.displayName = displayName;
        changeRequest?.commitChanges {(error) in
            if (error != nil) {
                print(error?.localizedDescription ?? "some error")
            }
        }
    }
    
    // sign up
    // Here to add display name
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    // sign in
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            print("Execute sign out!");
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind();
    }
}

struct User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, email: String? , displayName: String? ) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
