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

final class SignInViewController: UIViewController, StoryboardView {
    
    // MARK: UI Elements

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var disposeBag: DisposeBag = DisposeBag()


    // MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Instance methods
    
    func bind(reactor: SignInReactor) {
        bindState(reactor: reactor)
        bindActions(reactor: reactor)
    }
}
