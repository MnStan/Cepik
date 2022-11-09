//
//  CAlertVC.swift
//  Cepik
//
//  Created by Maksymilian Stan on 09/11/2022.
//

import SwiftUI

struct CAlertVC: View {
    var body: some View {
        VStack(spacing: 10) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("This is custom test alert please do something. Testowanie testowania")
                .multilineTextAlignment(.center)
            Button("Ok") {
                
            }
            .padding()
            .background(Color(.red))
            .clipShape(Capsule())
            .overlay(
                Capsule(style: RoundedRectangle(cornerSize: 5))
                    .stroke(.black, lineWidth: 5)
            )
        }
        .cornerRadius(5.0)
        
    }
}

struct CAlertVC_Previews: PreviewProvider {
    static var previews: some View {
        CAlertVC()
    }
}
