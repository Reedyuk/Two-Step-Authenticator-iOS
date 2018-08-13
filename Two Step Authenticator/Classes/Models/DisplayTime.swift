//
//  DisplayTime.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 13/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation

/// A simple value representing a moment in time, stored as the number of seconds since the epoch.
struct DisplayTime {
    let timeIntervalSince1970: TimeInterval

    init(date: Date) {
        timeIntervalSince1970 = date.timeIntervalSince1970
    }

    var date: Date {
        return Date(timeIntervalSince1970: timeIntervalSince1970)
    }

    static func currentDisplayTime() -> DisplayTime {
        return DisplayTime(date: Date())
    }
}
