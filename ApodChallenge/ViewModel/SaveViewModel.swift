//
//  SaveViewModel.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-31.
//

import Foundation
import RealmSwift

class SaveViewModel: ObservableObject {

    @ObservedResults(ApodObject.self) var apodLists
    @Published var apodList: [ApodObject] = []
    @Published var isLoading = true

    private var token: NotificationToken?

    init() {
        setupObserver()
    }

    deinit {
        token?.invalidate()
    }
    
    private func setupObserver() {
        do {
            let realm = try Realm()
            let results = realm.objects(ApodObject.self)
            print(results)
            token = results.observe({ [weak self] changes in
                self?.apodList = results.map(ApodObject.init)
                    .sorted(by: { $0.date > $1.date })
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Add contact
    func addApod(apod: ApodObject) {
        $apodLists.append(apod)
    }
        
    // Delete contact
    func remove(id: String) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: id)
            if let apod = realm.object(ofType: ApodObject.self, forPrimaryKey: objectId) {
                try realm.write {
                    realm.delete(apod)
                }
            }
        } catch let error {
            print(error)
        }
    }
}
