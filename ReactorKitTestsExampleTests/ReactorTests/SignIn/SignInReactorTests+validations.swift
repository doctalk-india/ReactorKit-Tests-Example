//
//  SignInReactorTests+validations.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 12/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxBlocking
import Stubber

extension SignInReactorTests {
    internal func testValidations() {
        describe("validations") {
            self.testEmailValidation()
            self.testPasswordValidation()
        }
    }
    
    private func testEmailValidation() {
        context("when invalid email is entered") {
            it("has shown invalid email error") {
                let disposeBag = DisposeBag()
                Observable.of(.signIn(email: self.invalidEmail, password: self.defaultPassword))
                    .delay(1, scheduler: MainScheduler.instance)
                    .bind(to: self.signInReactor.action)
                    .disposed(by: disposeBag)
                
                guard let state = try? self.signInReactor.state.skip(1).take(1).toBlocking(timeout: 5).first(), let errorMessage = state?.errorMessage else {
                    fail("It should emit error state")
                    return
                }
                expect(errorMessage).to(equal(SignInReactor.ErrorMessage.invalidEmail), description: "It should show the correct error message")
            }
        }
    }
    
    private func testPasswordValidation() {
        context("when invalid password is entered") {
            it("has shown invalid password error") {
                let disposeBag = DisposeBag()
                Observable.of(.signIn(email: self.defaultEmail, password: self.invalidPassword))
                    .delay(1, scheduler: MainScheduler.instance)
                    .bind(to: self.signInReactor.action)
                    .disposed(by: disposeBag)
                
                guard let state = try? self.signInReactor.state.skip(1).take(1).toBlocking(timeout: 5).first(), let errorMessage = state?.errorMessage else {
                    fail("It should emit error state")
                    return
                }
                expect(errorMessage).to(equal(SignInReactor.ErrorMessage.invalidPassword), description: "It should show the correct error message")
            }
        }
    }
}
