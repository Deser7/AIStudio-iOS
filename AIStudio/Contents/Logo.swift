//
//  Logo.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 20.06.2026.
//

import SwiftUI

struct Logo: View {
    var size: CGFloat
    var colorOne: Color
    var colorTwo: Color
    
    var body: some View {
        ZStack {
            AppGradient.linear(from: colorOne, to: colorTwo)
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            GenerateIcon()
                .fill(.accent)
                .frame(width: size * 0.6125, height: size * 0.6125)
        }
    }
}

#Preview {
    HStack {
        Logo(
            size: 40,
            colorOne: .logoBlueOne,
            colorTwo: .logoBlueTwo
        )
        
        Logo(
            size: 32,
            colorOne: .logoBlueOne,
            colorTwo: .logoBlueTwo
        )
        
        Logo(
            size: 40,
            colorOne: .logoGreenOne,
            colorTwo: .logoGreenTwo
        )
        
        Logo(
            size: 32,
            colorOne: .logoGreenOne,
            colorTwo: .logoGreenTwo
        )
        
        Logo(
            size: 40,
            colorOne: .logoPinkOne,
            colorTwo: .logoPinkTwo
        )
        
        Logo(
            size: 32,
            colorOne: .logoPinkOne,
            colorTwo: .logoPinkTwo
        )
        
        Logo(
            size: 40,
            colorOne: .logoPurpleOne,
            colorTwo: .logoPurpleTwo
        )
        
        Logo(
            size: 32,
            colorOne: .logoPurpleOne,
            colorTwo: .logoPurpleTwo
        )
    }
}
