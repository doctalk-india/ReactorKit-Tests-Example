//
//  SignInReactorTests.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 06/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import Quick

final class SignInReactorTests: QuickSpec {
    
    var authRepository: AuthRepositoryStub!
    var signInReactor: SignInReactor!
    let defaultEmail = "test@apple.com"
    let defaultPassword = "123456789"
    let defaultName = "Apple User"
    
    // Invalid
    let invalidEmail = "&*#&*#*&!@gmail.com"
    let invalidPassword = "       some"
    
    override func spec() {
        beforeSuite {
            self.authRepository = AuthRepositoryStub()
            self.signInReactor = SignInReactor(authRepository: self.authRepository)
        }
        
        self.testValidations()
        self.testSignInRequest()
    }
}

