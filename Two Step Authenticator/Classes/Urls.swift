//
//  Urls.swift
//  TabMarvelApp
//
//  Created by Andrew Reed on 07/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation

// swiftlint:disable line_length
public struct Urls {
    private static let marvelGateWayUrl = "http://gateway.marvel.com/v1/"
    private static let apiKey = "ff3d4847092294acc724123682af904b"
    static let charactersUrl = URL(string: "\(Urls.marvelGateWayUrl)public/characters?ts=1&apikey=\(Urls.apiKey)&hash=412b0d63f1d175474216fadfcc4e4fed&limit=25&orderBy=-modified")!
}
// swiftlint:enable line_length
