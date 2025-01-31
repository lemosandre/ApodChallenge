//
//  ApodRealm.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-31.
//

import Foundation
import RealmSwift

// MARK: - ApodRealm
struct ApodModel: Identifiable {
    var id: String
    var date: String
    var explanation: String
    var hdurl: String
    var mediaType: String
    var serviceVersion: String
    var title: String
    var url: String
    var copyright: String
    
    init(apod: ApodObject) {
        self.id = apod.id.stringValue
        self.date = apod.date
        self.explanation = apod.date
        self.hdurl = apod.hdurl
        self.mediaType = apod.mediaType
        self.serviceVersion = apod.serviceVersion
        self.title = apod.title
        self.url = apod.url
        self.copyright = apod.copyright
    }
}


class ApodObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: String
    @Persisted var explanationone: String
    @Persisted var hdurl: String
    @Persisted var mediaType: String
    @Persisted var serviceVersion: String
    @Persisted var title: String
    @Persisted var url: String
    @Persisted var copyright: String
}
