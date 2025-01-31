//
//  Apod.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Foundation

// MARK: - Apod
struct Apod: Codable {
    var date: String = ""
    var explanation: String? = ""
    var hdurl: String? = ""
    var mediaType: String? = ""
    var serviceVersion: String? = ""
    var title: String = ""
    var url: String? = ""
    var copyright: String? = ""

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
