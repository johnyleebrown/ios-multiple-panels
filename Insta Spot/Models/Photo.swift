//
//  Photo.swift
//  Insta Spot
//
//  Created by Grigorii Shevchenko on 1/31/19.
//  Copyright © 2019 Grigorii Shevchenko. All rights reserved.
//

import UIKit

/// A struct representing a photo from the Unsplash API.
public struct Photo: Codable {
    
    public enum URLKind: String, Codable {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    public enum LinkKind: String, Codable {
        case own = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
    
    public let identifier: String
    public let height: Int
    public let width: Int
    public let color: UIColor?
    public let urls: [URLKind: URL]
    public let links: [LinkKind: URL]
    public let likesCount: Int
    public let downloadsCount: Int?
    public let viewsCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height
        case width
        case color
        case urls
        case links
        case likesCount = "likes"
        case downloadsCount = "downloads"
        case viewsCount = "views"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        color = try container.decode(UIColor.self, forKey: .color)
        urls = try container.decode([URLKind: URL].self, forKey: .urls)
        links = try container.decode([LinkKind: URL].self, forKey: .links)
        likesCount = try container.decode(Int.self, forKey: .likesCount)
        downloadsCount = try? container.decode(Int.self, forKey: .downloadsCount)
        viewsCount = try? container.decode(Int.self, forKey: .viewsCount)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(height, forKey: .height)
        try container.encode(width, forKey: .width)
        try? container.encode(color?.hexString, forKey: .color)
        try container.encode(urls.convert({ ($0.key.rawValue, $0.value.absoluteString) }), forKey: .urls)
        try container.encode(links.convert({ ($0.key.rawValue, $0.value.absoluteString) }), forKey: .links)
        try container.encode(likesCount, forKey: .likesCount)
        try? container.encode(downloadsCount, forKey: .downloadsCount)
        try? container.encode(viewsCount, forKey: .viewsCount)
    }
    
}

extension KeyedDecodingContainer {
    func decode(_ type: UIColor.Type, forKey key: Key) throws -> UIColor {
        let hexColor = try self.decode(String.self, forKey: key)
        return UIColor(hexString: hexColor)
    }
    
    func decode(_ type: [Photo.URLKind: URL].Type, forKey key: Key) throws -> [Photo.URLKind: URL] {
        let urlsDictionary = try self.decode([String: String].self, forKey: key)
        var result = [Photo.URLKind: URL]()
        for (key, value) in urlsDictionary {
            if let kind = Photo.URLKind(rawValue: key),
                let url = URL(string: value) {
                result[kind] = url
            }
        }
        return result
    }
    
    func decode(_ type: [Photo.LinkKind: URL].Type, forKey key: Key) throws -> [Photo.LinkKind: URL] {
        let linksDictionary = try self.decode([String: String].self, forKey: key)
        var result = [Photo.LinkKind: URL]()
        for (key, value) in linksDictionary {
            if let kind = Photo.LinkKind(rawValue: key),
                let url = URL(string: value) {
                result[kind] = url
            }
        }
        return result
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        
        // swiftlint:disable fallthrough
        switch chars.count {
        case 3:
            chars = [chars[0], chars[0], chars[1], chars[1], chars[2], chars[2]]
            fallthrough
        case 6:
            chars = ["F", "F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            alpha = 0
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var redComponent: CGFloat { return cgColor.components?[0] ?? 0 }
    var greenComponent: CGFloat { return cgColor.components?[1] ?? 0 }
    var blueComponent: CGFloat { return cgColor.components?[2] ?? 0 }
    var alpha: CGFloat {
        guard let components = cgColor.components else {
            return 1
        }
        return components[cgColor.numberOfComponents-1]
    }
    
    var hexString: String {
        return NSString(format: "%02X%02X%02X%02X", Int(round(redComponent * 255)), Int(round(greenComponent * 255)), Int(round(blueComponent * 255)), Int(round(alpha * 255))) as String
    }
}

extension Dictionary {
    public func convert<T, U>(_ transform: ((key: Key, value: Value)) throws -> (T, U)) rethrows -> [T: U] {
        var dictionary = [T: U]()
        for (key, value) in self {
            let transformed = try transform((key, value))
            dictionary[transformed.0] = transformed.1
        }
        return dictionary
    }
}
