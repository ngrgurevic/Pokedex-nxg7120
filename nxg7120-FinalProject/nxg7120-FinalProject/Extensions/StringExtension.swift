//
//  StringExtension.swift
//  nxg7120-FinalProject
//
//  Created by Anita Jularic on 12/8/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
