//
//  Badge.swift
//  MakeTheFuckingBadge
//
//  Created by George Crisan on 20/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import SwiftUI

struct Badge: View {
    var body: some View {
        ZStack {
            BadgeBackground()
            BadgeText()
                .foregroundColor(Color.white)
        }
        
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
