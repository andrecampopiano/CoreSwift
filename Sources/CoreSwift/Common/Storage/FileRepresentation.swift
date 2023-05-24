//
//  FileRepresentation.swift
//  GitHubUserInformation
//
//  Created by Andre Luis Campopiano on 20/05/23.
//

import Foundation

/// DecoderData protocol
public protocol DecoderData {

    /// Decodes the given data to the specified type, since it conforms to Decodable
    /// - Parameters:
    ///   - type: The decoding result type
    ///   - data: The data to be decoded
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

/// File representation
public struct FileRepresentation {

    // MARK: Enums
    public enum FileRepresentationError: Error {
        case invalidData
    }

    public enum Extension: String {
        case json
        case html
        case pdf
        case plist
    }

    // MARK: Properties

    private var fileName: String?
    private var fileExtension: Extension?
    private var fileBundle: Bundle?
    private var fileData: Data?

    /// Path string
    public var path: String? {
        guard let url = fileBundle?.url(forResource: fileName ?? String(),
                                        withExtension: fileExtension?.rawValue ?? String())
            else {
                return String()
        }
        return url.absoluteString
    }

    /// Data representation
    public var data: Data? {
        if let data = fileData {
            return data
        }

        guard let url = fileBundle?.url(forResource: fileName ?? String(),
                                        withExtension: fileExtension?.rawValue ?? String())
            else {
                return nil
        }
        guard let data = try? Data(contentsOf: url) else { return nil }

        return data
    }

    /// Json representation
    public var json: [String: AnyObject]? {
        if let data = data {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
        }

        return nil
    }

    // MARK: Public Methods

    /// Initializer
    ///
    /// - Parameters:
    ///   - fileName: File name
    ///   - fileExtension: File extension
    ///   - fileBundle: File bundle
    public init(withFileName fileName: String, fileExtension: Extension, fileBundle: Bundle) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.fileBundle = fileBundle
    }

    /// Initializer
    ///
    /// - Parameter fileData: file data
    public init(withFileData fileData: Data) {
        self.fileData = fileData
    }

    /// Return file model
    ///
    /// - Parameters:
    ///   - type: O tipo do model requeride Decodable)
    ///   - decoder: Custom JSONDecoder, if necessary
    /// - Returns: File model
    /// - Throws: Throw exceptions in case of an error in obtaining the binary or decoding
    public func decoded<T: Decodable>(to type: T.Type, using decoder: DecoderData) throws -> T {
        guard let data = data else { throw FileRepresentationError.invalidData }

        return try decoder.decode(type, from: data)
    }
}

/// Decoder protocol adoptance
extension PropertyListDecoder: DecoderData {
    /* Intentionally unimplemented */
}

/// Decoder protocol adoptance
extension JSONDecoder: DecoderData {
    /* Intentionally unimplemented */
}
