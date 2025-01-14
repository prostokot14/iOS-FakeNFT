//
//  String+Extensions.swift
//  FakeNFT
//
//  Created by Andy Kruch on 14.10.23.
//

import Foundation

extension String {
    var encodeURL: String {
        if let encodedString = self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            return encodedString
        } else {
            return "encode error!"
        }
    }
    var decodeURL: String {
        if let decodedString =  self.removingPercentEncoding {
            return decodedString
        } else {
            return "decode error!"
        }
    }
}
