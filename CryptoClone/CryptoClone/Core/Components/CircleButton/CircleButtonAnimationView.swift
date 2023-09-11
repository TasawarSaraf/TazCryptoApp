//
//  CircleButtonAnimationView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/26/22.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    // can never be private
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0: 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none, value: animate)

    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        // binding default ".constant"
        CircleButtonAnimationView(animate: .constant(false)).foregroundColor(Color.red)
            .frame(width: 100, height: 100)
    }
}
