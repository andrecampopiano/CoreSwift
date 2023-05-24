//
//  String.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

public extension String {
    
    private enum Constants {
        static let accessibilityLocalizable: String = "AccessibilityLocalizable"
        static let localizable: String = "Localizable"
    }
    
    // MARK: - Public Methods
    
    /// Get localized string
    ///
    /// - Parameters:
    ///   - accessibilty: bool indicating if it's accessibility or not
    ///   - bundle: Bundle to retrieve file
    func localize(_ accessibilty: Bool = false, bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: accessibilty ? Constants.accessibilityLocalizable : Constants.localizable, bundle: bundle, value: String(), comment: String())
    }
}
