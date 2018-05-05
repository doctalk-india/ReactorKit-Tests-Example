//
//  AuthRepositoryType.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 06/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import RxSwift

protocol AuthRepositoryType {
    func signIn(email: String, password: String) -> Single<[String: Any]>
}
