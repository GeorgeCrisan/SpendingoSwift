//
//  BadgeText.swift
//  MakeTheFuckingBadge
//
//  Created by George Crisan on 20/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import SwiftUI

struct BadgeText: View {
    var body: some View {
        Text("SpendingoSwift")
            .font(.custom("Mina-Bold", size: 40))
    }
}

struct BadgeText_Previews: PreviewProvider {
    static var previews: some View {
        BadgeText()
    }
}
