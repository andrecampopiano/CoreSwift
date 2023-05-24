//
//  BaseProviderMock.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 22/05/23.
//

import Foundation

class BaseProviderMock {

    private var jsonFile: String
    private var bundle: Bundle

    init(jsonFile: String, bundle: Bundle) {
        self.jsonFile = jsonFile
        self.bundle = bundle
    }

    func jsonWithFile() -> Data? {
        let filename = jsonFile

        if let path = bundle.path(forResource: filename, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path))
        } else {
           return nil
        }
    }
}
