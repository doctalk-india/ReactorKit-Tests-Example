//
//  AuthRepositoryStub.swift
//  ReactorKitTestsExampleTests
//
//  Created by Sourav Chandra on 06/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import RxSwift
import Stubber

struct AuthRepositoryStub: AuthRepositoryType {
    func signIn(email: String, password: String) -> Observable<SignInResult> {
        return Stubber.invoke(signIn, args: (email, password), default: .never())
    }
}
