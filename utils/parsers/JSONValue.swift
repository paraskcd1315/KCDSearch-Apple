//
//  JSONValue.swift
//  kcdsearch
//
//  Created by ParasKCD on 14/3/26.
//

import Foundation

enum JSONValue: Decodable {
    case string(String)
    case array([JSONValue])
    case number(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let arr = try? container.decode([JSONValue].self) {
            self = .array(arr)
        } else if let num = try? container.decode(Double.self) {
            self = .number(num)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported JSON value")
        }
    }
}
