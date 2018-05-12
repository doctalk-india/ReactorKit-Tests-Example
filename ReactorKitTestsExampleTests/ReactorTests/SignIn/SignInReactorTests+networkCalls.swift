//
//  SignInReactorTests+networkCalls.swift
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
    
    internal func testSignInRequest() {
        describe("network request") {
            
            beforeEach {
                Stubber.clear()
            }
            
            self.testSignInFailed()
            self.testSignInSuccess()
        }
    }
    
    private func testSignInFailed() {
        context("correct email and password entered but request failed") {
            it ("has show an error") {
                Stubber.register(self.authRepository.signIn) { _ in .just(.failure(error: SignInReactor.ErrorMessage.signInFailed.rawValue)) }
                
                let disposeBag = DisposeBag()
                Observable.of(.signIn(email: self.defaultEmail, password: self.defaultPassword))
                    .delay(1, scheduler: MainScheduler.instance)
                    .bind(to: self.signInReactor.action)
                    .disposed(by: disposeBag)
                
                let states = try? self.signInReactor.state.skip(1).take(2).toBlocking(timeout: 5).toArray()
                
                guard let loadingState = states?.first else {
                    fail("It should emit a loading state")
                    return
                }
                
                guard let failureState = states?.last else {
                    fail("It should emit a failure state")
                    return
                }
                
                expect(Stubber.executions(self.authRepository.signIn).count).to(equal(1), description: "It should only call sign in once")
                expect(loadingState.isLoading).to(equal(true), description: "loading state should have loading as true")
                expect(failureState.errorMessage).to(equal(SignInReactor.ErrorMessage.signInFailed), description: "Error message should be \(SignInReactor.ErrorMessage.signInFailed.rawValue)")
                expect(failureState.isLoading).to(equal(false), description: "loading state should have loading as false")
            }
        }
    }
    
    private func testSignInSuccess() {
        context("correct email and password entered") {
            it ("has set the ") {
                Stubber.register(self.authRepository.signIn) { _ in .just(.success(User(name: self.defaultName, email: self.defaultEmail))) }
                
                let disposeBag = DisposeBag()
                Observable.of(.signIn(email: self.defaultEmail, password: self.defaultPassword))
                    .delay(1, scheduler: MainScheduler.instance)
                    .bind(to: self.signInReactor.action)
                    .disposed(by: disposeBag)
                
                let states = try? self.signInReactor.state.skip(1).take(2).toBlocking(timeout: 5).toArray()
                
                guard let loadingState = states?.first else {
                    fail("It should emit a loading state")
                    return
                }
                
                guard let signedInState = states?.last else {
                    fail("It should emit a signed in success state")
                    return
                }
                
                expect(Stubber.executions(self.authRepository.signIn).count).to(equal(1), description: "It should only call sign in once")
                expect(loadingState.isLoading).to(equal(true), description: "loading state should have loading as true")
                expect(signedInState.errorMessage).to(beNil(), description: "There should be no errors in the state")
                expect(signedInState.isLoading).to(equal(false), description: "loading state should have loading as false")
                expect(signedInState.currentUser).toNot(beNil(), description: "Current user should be assigned to the state after the sign in is successful.")
                expect(signedInState.message).to(equal(SignInReactor.Message.loggedIn), description: "It should show correct success message")
            }
        }
    }
}
