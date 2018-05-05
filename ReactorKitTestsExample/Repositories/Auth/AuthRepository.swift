//
//  AuthRepository.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 06/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import RxSwift

struct AuthRepository: AuthRepositoryType {
    
    /// I'm just simulating a network request here.
    func signIn(email: String, password: String) -> Single<[String: Any]> {
        return Single.just([:]).delay(5, scheduler: MainScheduler.instance)
    }
}
