//
//  ContentView.swift
//  SwiftUICombine
//
//  Created by 黃柏嘉 on 2025/02/07.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    @State var showAlert: Bool = false
    @State var message: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LoginInputView(text: $viewModel.userName,
                           title: "帳號",
                           placeHolder: "輸入使用者名稱")
            
            LoginInputView(text: $viewModel.password,
                           title: "密碼",
                           placeHolder: "輸入密碼")
            
            Button(action: {
                viewModel.login()
            }, label: {
                Text("登入")
            })
            .disabled(!viewModel.isLoginEnabled)
        }
        .padding()
        .alert(message, isPresented: $showAlert, actions: {
            Button("確認", role: .none, action: {})
        })
        .onReceive(viewModel.loginResult, perform: { result in
            showAlert = true
            message = result
        })
    }
}

#Preview {
    ContentView()
}
