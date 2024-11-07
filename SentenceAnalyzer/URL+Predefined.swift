//
//  URL+Predefined.swift
//  SentenceAnalyzer
//
//  Created by 전율 on 11/6/24.
//

import Foundation

extension URL {
    static let dataURL = Bundle.main.url(forResource: "data", withExtension: "txt")!
    static let tempFileURL = temporaryDirectory.appending(path: "data.txt")
}
