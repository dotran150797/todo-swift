//
//  ViewExtendsion.swift
//  tudu-app
//
//  Created by Do Tran on 25/2/25.
//

import SwiftUI

// Custom View Modifier
struct LatoFontModifier: ViewModifier {
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Regular", size: size))
    }
}

struct LatoBoldFontModifier: ViewModifier {
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Bold", size: size))
    }
}

// Extend View to apply the modifier easily
extension View {
    func latoFont(size: CGFloat) -> some View {
        self.modifier(LatoFontModifier(size: size))
    }
    
    func latoBoldFont(size: CGFloat) -> some View {
        self.modifier(LatoBoldFontModifier(size: size))
    }
}
