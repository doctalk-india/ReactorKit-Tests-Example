//
//  SignInViewController.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 06/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import UIKit
import ReactorKit
import RxSwift

final class SignInViewController: UIViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: Init methods
    
    init(reactor: SignInViewModel) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Instance methods
    
    func bind(reactor: SignInViewModel) {
        bindState(reactor: reactor)
        bindActions(reactor: reactor)
    }
}
