//
//  YoutubeSearchResponse.swift
//  Netflix_Clone
//
//  Created by Lina on 5/12/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IDVideoElement
}

struct IDVideoElement: Codable {
    let kind: String
    let videoId: String
}
