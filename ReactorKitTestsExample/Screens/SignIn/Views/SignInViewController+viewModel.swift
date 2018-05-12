//
//  SignInViewController+viewModel.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 12/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension SignInViewController {

    // MARK: Bind Actions
    
    internal func bindActions(reactor: SignInReactor) {
        bindSignInAction(reactor: reactor)
        bindErrorClearing(reactor: reactor)
    }
    
    private func bindSignInAction(reactor: SignInReactor) {
        signInButton.rx.tap
            .withLatestFrom(Observable.combineLatest(
                emailTextField.rx.text.orEmpty,
                passwordTextField.rx.text.orEmpty
            ))
            .map { .signIn(email: $0.0, password: $0.1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindErrorClearing(reactor: SignInReactor) {
        Observable.merge([
                emailTextField.rx.text.orEmpty.distinctUntilChanged(),
                passwordTextField.rx.text.orEmpty.distinctUntilChanged()
            ])
            .map { _ in .clearErrors }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    // MARK: Bind State
    
    internal func bindState(reactor: SignInReactor) {
        bindLoadingState(reactor: reactor)
        bindErrorState(reactor: reactor)
        bindLoggedInState(reactor: reactor)
    }
    
    private func bindLoadingState(reactor: SignInReactor) {
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .not()
            .bind(to: emailTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .not()
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .not()
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindErrorState(reactor: SignInReactor) {
        reactor.state.map { $0.errorMessage?.rawValue }
            .bind(to: errorLabel.rx.error)
            .disposed(by: disposeBag)
    }
    
    private func bindLoggedInState(reactor: SignInReactor) {
        reactor.state.map { $0.message?.rawValue }
            .bind(to: messageLabel.rx.success)
            .disposed(by: disposeBag)
    }
}
