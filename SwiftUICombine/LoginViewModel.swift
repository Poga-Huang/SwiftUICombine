//
//  LoginViewModel.swift
//  SwiftUICombine
//
//  Created by 黃柏嘉 on 2025/02/07.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled: Bool = false
    let loginResult = PassthroughSubject<String, Never>()
    
    private let loginVerification: VerificationProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(validator: VerificationProtocol = LoginVerification()) {
        
        loginVerification = validator
        
        setupBinding()
    }

    private func setupBinding() {
        Publishers.CombineLatest($userName, $password)
            .receive(on: DispatchQueue.main)
            .map { userName, password in
                return userName.count > 0 && password.count > 0
            }
            .sink(receiveValue: { [weak self] isEnabled in
                self?.isLoginEnabled = isEnabled
            })
            .store(in: &cancellables)
    }
    
    func login() {
        loginVerification.verify(userName: userName,
                                 password: password)
        { [weak self] result in
            switch result {
            case .success(let success):
                self?.loginResult.send(success)
            case .failure(let failure):
                self?.loginResult.send((failure as! VerifiyError).errorMessage)
            }
        }
    }
}
