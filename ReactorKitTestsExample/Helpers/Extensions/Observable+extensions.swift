//
//  Observable+extensions.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 12/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Self.E == Bool {
    func not() -> Observable<Bool> {
        return self.map { !$0 }
    }
}

extension Reactive where Base: UILabel {
    
    /// Bindable sink for error messages
    public var error: Binder<String?> {
        return Binder(self.base) { label, text in
            label.text = text
            label.textColor = .red
        }
    }
    
    /// Bindable sink for error messages
    public var success: Binder<String?> {
        return Binder(self.base) { label, text in
            label.text = text
            label.textColor = .green
        }
    }
}
