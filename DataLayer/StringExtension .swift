//
//  StringExtension .swift
//  hackerNews
//
//  Created by Michiel Everts on 31-10-17.
//  Copyright © 2017 Michiel Everts. All rights reserved.
//

import Foundation

extension String{
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(self.characters.filter {okayChars.contains($0) })
    }
}
