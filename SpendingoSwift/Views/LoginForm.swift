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
            Text("Login")
            VStack(alignment: .leading, spacing: 20) {
                TextField("Email address", text: $email)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(Color.black, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.black, lineWidth: 1))
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 32)
            
            Button(action: signIn) {
                if(!self.loading) {
                    Text("Sign In")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .font(.custom("Mina-Regular", size: 14))
                    .cornerRadius(5)
                } else {
                    Text("Loading...")
                }
            }
            .disabled(self.loading)
            .padding(.horizontal, 32)
            
            VStack {
                if(error != ""){
                    Text(error)
                        .font(.custom("FireSans-Bold", size: 14))
                        .foregroundColor(Color.red)
                        .padding()
                }
            }
            
            Spacer()
            
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text("Create an account.")
                        .font(.custom("Mina", size: 26))
                        .foregroundColor(Color.blue)
                }
            }
            .padding(.horizontal, 32)
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
            Text("Create accont")
            VStack(alignment: .leading, spacing: 20) {
                
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
            .padding(.horizontal, 32)
            .padding(.vertical, 32)
            
            Button(action: signUp) {
                
                if(self.loading) {
                    Text("Loading ...")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                } else {
                    Text("Create account.")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .font(.custom("Mina-Regular", size: 14))
                    .cornerRadius(5)
                }
                
            }
            .disabled(self.loading)
            .padding(.horizontal, 32)
            
            VStack {
                if(error != ""){
                    Text(error)
                        .font(.custom("FireSans-Bold", size: 14))
                        .foregroundColor(Color.red)
                        .padding()
                }
                
                if(self.displayName.count < 4){
                    Text("Display name must have minimum 3 charactes.")
                        .font(.custom("FireSans-Bold", size: 14))
                        .foregroundColor(Color.red)
                        .padding()
                }
            }
            
            Spacer()
            
        }
        
    }
}



struct LoginForm: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
