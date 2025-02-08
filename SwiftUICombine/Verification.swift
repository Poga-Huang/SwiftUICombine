//
//  Verification.swift
//  SwiftUICombine
//
//  Created by 黃柏嘉 on 2025/02/07.
//

import Foundation

protocol VerificationProtocol {
    func verify(
        userName: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    )
}

class LoginVerification: VerificationProtocol {
    
    let testUsername: String = "chris@gmail.com"
    let textPassword: String = "123456789"
    
    func verify(userName: String,
                password: String,
                completion: @escaping (Result<String, Error>) -> Void)
    {
        let result = userName == testUsername && password == textPassword
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            if result {
                completion(.success("登入成功"))
            }
            else {
                completion(.failure(VerifiyError(errorMessage: "登入失敗")))
            }
        })
    }
}

class VerifiyError: Error {
    
    var errorMessage: String
    
    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
