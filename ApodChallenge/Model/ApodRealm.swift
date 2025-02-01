//
//  ApodRealm.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-31.
//

import Foundation
import RealmSwift

// MARK: - ApodRealm
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
