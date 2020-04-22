//
//  LoginForm.swift
//  SpendingoSwift
//
//  Created by George Crisan on 21/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat ) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

let fieldGradinet =  LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .leading, endPoint: .trailing);
let appBlue = UIColor(r: 0 , g: 142, b: 207, a: 0.93)

struct ResetPassword: View {
    @State var email: String = ""
    @State var error: String = ""
    @State var emailResetDone: Bool = false
    @EnvironmentObject var session: SessionStore
    
    func resetPassword() {
        session.resetPassword(email: email) { (result,error) in
            print(result!);
            if let error = error  {
                print(error.localizedDescription);
                self.error = error.localizedDescription;
                self.emailResetDone = false;
            } else {
                self.error = "";
                self .emailResetDone = true;
            }
            
        }
        self.emailResetDone = true;
    }
    
    var body: some View {
            
        VStack(alignment: .leading, spacing: 16) {
            
            Spacer()
                .frame(width: 120, height: 100)
            
            if(self.emailResetDone) {
                HStack {
                    Spacer()
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(Color(appBlue))
                        .font(.system(size: 40))
                    Spacer()
                }
                
                Text("Your password reset submit has been sent. Please check your email address.")
                    .padding(16)
                    .font(.custom("Mina-Regular", size: 16))
            } else {
            
            VStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(Color(appBlue))
                        .font(.system(size: 40))
                    Text("Submit your email address and you will receive instructions to reset your password.")
                        .padding(16)
                        .font(.custom("Mina-Regular", size: 16))
            }
            
            TextField("Email address", text: $email)
                .font(.custom("FiraSans-Regular", size: 18))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(fieldGradinet, lineWidth: 1.5))
            
            Button(action: resetPassword) {
                Text("Reset password via email")
                .frame(maxWidth: 330)
                .frame(height: 50)
                .foregroundColor(.white)
                .background(Color(appBlue))
                .font(.custom("Mina-Bold", size: 18))
                .cornerRadius(5)
            }
            }
            Spacer()
        }
            .frame(maxWidth: 330)
            .padding(.bottom, 16)
            .navigationBarTitle(Text("Reset password"), displayMode: .inline)
    }
}

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var loading:Bool = false
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        self.loading = true;
        session.signIn(email: email, password: password) { (result, error) in
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
            
            Badge()
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 32) {
                
                TextField("Email address", text: $email)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(fieldGradinet, lineWidth: 1.5))
                
                SecureField("Password", text: $password)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(fieldGradinet, lineWidth: 1.5))
            }
            .frame(maxWidth: 330)
            .padding(.bottom, 16)
            
            VStack {
                Button(action: signIn) {
                    if(!self.loading) {
                        Text("Sign In")
                            .frame(maxWidth: 330)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color(appBlue))
                            .font(.custom("Mina-Bold", size: 18))
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
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        Text(error)
                            .font(.custom("FireSans-Bold", size: 14))
                            .foregroundColor(Color.red)
                    }
                    .frame(maxWidth: 330 , maxHeight: 50)
                    
                }
            }
            
            
            Spacer()
            
            VStack {
                NavigationLink(destination: SignUpView()) {
                    Text("Create an acount")
                        .foregroundColor(Color(appBlue))
                }
                .padding(.bottom, 8)
                
                NavigationLink(destination: ResetPassword()) {
                    Text("Reset password")
                        .foregroundColor(Color(appBlue))
                }
                .padding(.bottom, 32)
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
                .frame(width: 100, height: 40)
            
            Badge()
            
            Spacer()
                .frame(width: 100, height: 40)
            
            VStack(alignment: .leading, spacing: 16) {
                
                TextField("Display name", text: $displayName)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(fieldGradinet, lineWidth: 1.5))
                
                TextField("Email address", text: $email)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(fieldGradinet, lineWidth: 1.5))
                
                
                SecureField("Password", text: $password)
                    .font(.custom("FiraSans-Regular", size: 18))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 6).strokeBorder(fieldGradinet, lineWidth: 1.5))
            }
            .frame(maxWidth: 330)
            .padding(.bottom, 16)
            
            
            
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
                            .background(Color(appBlue))
                            .font(.custom("Mina-Bold", size: 16))
                            .cornerRadius(5)
                    }
                    
                }
                .disabled(self.loading)
                
                if(error != ""){
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(Color.red)
                            .font(.system(size: 20))
                        Text(error)
                            .font(.custom("FireSans-Bold", size: 14))
                            .foregroundColor(Color.red)
                    }
                    .frame(maxWidth: 330 , maxHeight: 50)
                }
                
                if(self.displayName.count < 4){
                    HStack {
                            Image(systemName: "exclamationmark.circle")
                                .foregroundColor(Color(appBlue))
                                .font(.system(size: 20))
                            Text("Display name must have minimum 3 charactes.")
                                .font(.custom("FireSans-Bold", size: 14))
                                .foregroundColor(Color(appBlue))
                        }
                        .frame(maxWidth: 330 , maxHeight: 50)
                    }
                
            }
            
            Spacer()
            
        }
        .navigationBarTitle(Text("Create an account"), displayMode: .inline)
    }
}



struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
