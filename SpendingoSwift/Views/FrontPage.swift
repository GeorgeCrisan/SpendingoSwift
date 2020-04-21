//
//  SwiftUIView.swift
//  SpendingoSwift
//
//  Created by George Crisan on 20/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import SwiftUI

struct FrontPage: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        VStack {
            if (session.session != nil) {
                VStack {
                    Text("You are logged in!");
                    Button(action: session.signOut) {
                        Text("Sign out")
                    }
                }
            } else {
                NavigationView {
                   SignInView()
                }
                .environment(\.horizontalSizeClass, .compact)
            }
        }
        .onAppear(perform: getUser)
        
    }
}

struct FrontPage_Previews: PreviewProvider {
    static var previews: some View {
        FrontPage().environmentObject(SessionStore())
    }
}
