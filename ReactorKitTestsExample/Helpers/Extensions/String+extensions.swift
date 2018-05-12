//
//  String+extensions.swift
//  ReactorKitTestsExample
//
//  Created by Sourav Chandra on 12/05/18.
//  Copyright © 2018 Sourav Chandra. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func trimWhitespacesAndNewLines() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
