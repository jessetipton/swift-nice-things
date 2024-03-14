//
//  EdgeInsets+Zero.swift
//
//
//  Created by Jesse Tipton on 3/14/24.
//

import SwiftUI

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
extension EdgeInsets {
    /// Edge insets whos top, leading, bottom, and trailing values are all zero.
    public static var zero: EdgeInsets {
        EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
}
