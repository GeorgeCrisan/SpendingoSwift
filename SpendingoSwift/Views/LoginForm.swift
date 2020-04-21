//
//  LoginForm.swift
//  SpendingoSwift
//
//  Created by George Crisan on 21/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var loading:Bool = false
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        self.loading = true;
        session.signIn(email: email, password: password) { (restult, error) in
            if let error = error {
                self.error = error.localizedDescription
                self.loading = false
            } else {
                self.password = ""
                self.email = ""
                self.error = ""
                self.loading = false
            }
            
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Login")
            VStack(alignment: .leading, spacing: 16) {
                TextField("Email address", text: $email)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(Color.black, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.black, lineWidth: 1))
            }
            .frame(maxWidth: 330)
            .padding(16)
            
            VStack {
                
                Button(action: signIn) {
                    if(!self.loading) {
                        Text("Sign In")
                            .frame(maxWidth: 330)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .font(.custom("Mina-Regular", size: 14))
                            .cornerRadius(5)
                    } else {
                        Text("Loading...")
                            .frame(maxWidth: 330)
                            .frame(height: 50)
                    }
                }
                .disabled(self.loading)
                .padding(16)
                
                if(error != ""){
                    Text(error)
                        .font(.custom("FireSans-Bold", size: 14))
                        .foregroundColor(Color.red)
                }
            }
            
            
            Spacer()
            
            /*VStack {
                Button(action: session.toggleLV){
                    Text("Create an account.")
                        .font(.custom("Mina", size: 26))
                        .foregroundColor(Color.blue)
                }
                .padding(.horizontal, 32)
            }*/
            
            NavigationLink(destination: SignUpView()) {
                Text("Select something")
            }
            
            Spacer()
        }
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var displayName: String = ""
    @State var error: String = ""
    @State var loading:Bool = false
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        self.loading = true;
        if(self.displayName.count < 4) {
            self.error = ""
            self.loading = false
            return;
        }
        
        session.signUp(email: self.email, password: self.password) { (result,error) in
            if let error = error {
                self.error = error.localizedDescription
                self.loading = false
            } else {
                self.password = ""
                self.email = ""
                self.error = ""
                self.loading = false
                
                self.session.updateUser(displayName: self.displayName) {(result,error) in
                    if let error = error {
                        self.error = error.localizedDescription
                        self.loading = false
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Create accont")
            VStack(alignment: .leading, spacing: 16) {
                
                TextField("Display name", text: $displayName)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(Color.black, lineWidth: 1))
                
                TextField("Email address", text: $email)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(Color.black, lineWidth: 1))
                
                
                SecureField("Password", text: $password)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.black, lineWidth: 1))
            }
            .frame(maxWidth: 330)
            .padding(16)
            
            
            
            VStack {
                Button(action: signUp) {
                    
                    if(self.loading) {
                        Text("Loading ...")
                            .frame(maxWidth: 330)
                            .frame(height: 50)
                    } else {
                        Text("Create account.")
                            .frame(maxWidth: 330)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .font(.custom("Mina-Regular", size: 14))
                            .cornerRadius(5)
                    }
                    
                }
                .disabled(self.loading)
                .padding(16)
                
                if(error != ""){
                    Text(error)
                        .font(.custom("FireSans-Bold", size: 14))
                        .foregroundColor(Color.red)
                }
                
                if(self.displayName.count < 4){
                    Text("Display name must have minimum 3 charactes.")
                        .font(.custom("FireSans-Bold", size: 14))
                        .foregroundColor(Color.red)
                }
            }
            
            /*VStack {
                Button(action: session.toggleLV){
                    Text("Back to login screen.")
                        .font(.custom("Mina", size: 26))
                        .foregroundColor(Color.blue)
                }
                .padding(.horizontal, 32)
            }*/
            
            Spacer()
            
        }
    }
}


