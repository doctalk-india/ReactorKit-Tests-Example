//
//  SignInReactor.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 06/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

final class SignInReactor: Reactor {
    
    enum ErrorMessage: String {
        case invalidEmail = "Please enter a valid email."
        case invalidPassword = "Your password should be atleast 8 characters long"
        case incorrectPassword = "The password you entered is incorrect. Please enter the correct password."
        case signInFailed = "Sign in failed. Please try again."
        case other = "Something went wrong"
    }
    
    enum Message: String {
        case loggedIn = "You are now signed in successfully."
    }

    // MARK: Properties
    
    internal let authRepository: AuthRepositoryType
    var initialState = State()
    
    // MARK: Enums

    enum Action {
        case signIn(email: String?, password: String?)
        case clearErrors
    }
    
    enum Mutation {
        case setUser(User)
        case setLoading
        case setError(ErrorMessage)
        case setClearingErrors
    }
    
    struct State {
        var currentUser: User?
        var message: Message?
        var errorMessage: ErrorMessage?
        var isLoading: Bool = false
    }

    // MARK: Init methods
    
    init(authRepository: AuthRepositoryType) {
        self.authRepository = authRepository
    }

    // MARK: Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .signIn(email, password): return mutateSignIn(email: email, password: password)
        case .clearErrors: return .just(.setClearingErrors)
        }
    }
    
    private func mutateSignIn(email: String?, password: String?) -> Observable<Mutation> {
        guard let `email` = email?.trimWhitespacesAndNewLines(), email.isEmail else { return .just(.setError(.invalidEmail))  }
        guard let `password` = password?.trimWhitespacesAndNewLines(), password.count >= 8 else { return .just(.setError(.invalidPassword))  }
        return authRepository.signIn(email: email, password: password).map { result in
            switch result {
            case let .success(user): return .setUser(user)
            case .failure: return .setError(.signInFailed)
            }
            
        }
        .startWith(.setLoading)
    }

    // MARK: Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        // Reset error message and message everytime a new mutation return.
        // So that you don't end up showing an error twice to the user.
        state.errorMessage = nil
        state.message = nil
        switch mutation {
        case let .setError(errorMessage):
            state.errorMessage = errorMessage
            state.isLoading = false
        case let .setUser(user):
            state.currentUser = user
            state.message = Message.loggedIn
            state.isLoading = false
        case .setLoading:
            state.isLoading = true
        default: break
        }
        return state
    }

    // MARK: Debugging

    func transform(state: Observable<State>) -> Observable<State> {
        return state.debug()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation.debug()
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        return action.debug()
    }
    
}
