//
//  StartPage.swift
//  AliasFrontend
//
//  Created by 1234 on 12.05.2023.
//

import Foundation
import SwiftUI

struct StartPage: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.linearGradient(colors: [.black, .mint], startPoint: .top, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            VStack {
                // add action
                Button { } label: {
                    ZStack {
                    
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .frame(width: 200, height: 70)
                            .foregroundColor(Color.mint)
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size:20, weight:.bold, design: .rounded))
                    }
                    
                    
                }
                Button { } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .frame(width: 200, height: 70)
                            .foregroundColor(Color.black)
                        Text("SignUp")
                            .foregroundColor(.white)
                            .font(.system(size:20, weight:.bold, design: .rounded))
                    }
                }
            }
        }
    }
    
    struct StartPage_Previews: PreviewProvider {
        static var previews: some View {
            StartPage()
        }
    }
}
