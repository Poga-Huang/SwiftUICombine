//
//  LoginInputView.swift
//  SwiftUICombine
//
//  Created by 黃柏嘉 on 2025/02/07.
//

import SwiftUI

struct LoginInputView: View {
    
    @Binding var text: String
    var title: String
    var placeHolder: String

    var body: some View {
        HStack(alignment: .center){
            Text(title)
            
            TextField(text: $text) {
                Text(placeHolder)
            }
            .padding(8)
            .border(.gray, width: 1)
        }
        .frame(maxWidth: 200)
    }
}
