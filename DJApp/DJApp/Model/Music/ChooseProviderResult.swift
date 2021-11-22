//
//  ChooseProviderResult.swift
//  DJApp
//
//  Created by Sam on 11/21/21.
//

import Foundation

enum ChooseProviderError {
    case unknown
}

enum ChooseProviderResult {
    case success
    case failure(_ error: ChooseProviderError)
}
