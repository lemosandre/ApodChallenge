//
//  SaveViewModel.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-31.
//

import Foundation
import RealmSwift

class SaveViewModel: ObservableObject {
    @Published var isLoading = true
    
    var token: NotificationToken?

    func getApodRealm(
        callBack: @escaping () -> Void,
        failure: @escaping (_ error: String) -> Void
    ) {
        do {
            let realm = try Realm()
            let results = realm.objects(ApodObject.self)
            token = results.observe({ changes in
                print("Changes: \(changes)")
            })
            callBack()
        } catch let error {
            failure(error.localizedDescription)
        }
    }
        
    func removeApod(
        id: String,
        failure: @escaping (_ error: String) -> Void)
    {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: id)
            if let apod = realm.object(ofType: ApodObject.self, forPrimaryKey: objectId) {
                try realm.write {
                    realm.delete(apod)
                }
            }
        } catch let error {
            failure(error.localizedDescription)
        }
    }
}
