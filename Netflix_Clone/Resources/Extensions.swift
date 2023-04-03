//
//  Extensions.swift
//  Netflix_Clone
//
//  Created by Lina on 28/11/22.
//

import Foundation

//Impplemented in Home titles: Trending, Upcoming...
extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
