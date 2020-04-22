//
//  ContentView.swift
//  MakeTheFuckingBadge
//
//  Created by George Crisan on 20/04/2020.
//  Copyright © 2020 George Crisan. All rights reserved.
//

import SwiftUI

struct BadgeBackground: View {
    static let gradientStart = Color(red: 27.0 / 255, green: 155.0 / 255, blue: 181.0 / 255)
    static let gradientEnd = Color(red: 36.0 / 255, green: 36.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        GeometryReader { geometry in
            
            Path { path in
                var width:CGFloat =  min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.932
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                
                path.move(
                    to: CGPoint(
                        x: xOffset + width * 0.95,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                HexagonParameters.points.forEach {
                    path.addLine(
                        to: .init(
                            x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
                            y: height * $0.useHeight.0 * $0.yFactors.0
                        )
                    )
                    
                    path.addQuadCurve(
                        to: .init(
                            x:xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                            y: height * $0.useHeight.1 * $0.yFactors.1
                        ),
                        control: .init(
                            x:xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                            y: height * $0.useHeight.2 * $0.yFactors.2
                        )
                    )
                }
            }
            .fill(LinearGradient(
                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: .init(x: 0.3, y: 0),
                endPoint: .init(x: 0.7, y: 0.7)
            ))
                .aspectRatio(1, contentMode: .fit)
                .blur(radius: /*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
        .frame(width: 200, height: 200, alignment: .center )
    }
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
