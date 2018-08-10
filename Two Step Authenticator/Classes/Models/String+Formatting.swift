//
//  String+Formatting.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 09/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit

extension String {
    public static func formatLabel(text: String,
                                   font: UIFont,
                                   textColour: UIColor,
                                   style: NSMutableParagraphStyle? = nil) -> NSAttributedString {
        var attributes = [NSAttributedStringKey.font: font,
                          NSAttributedStringKey.foregroundColor: textColour]
        if let style = style {
            attributes[NSAttributedStringKey.paragraphStyle] = style
        }
        return NSAttributedString(string: text,
                                  attributes: attributes)
    }
}
