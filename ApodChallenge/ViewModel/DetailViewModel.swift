//
//  DetailViewModel.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Foundation
import RealmSwift

class DetailViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var apod: Apod = Apod()
    @Published var isSaved: Bool = false
    @ObservedResults(ApodObject.self) var apodList

    func getApodDate(
        date: String,
        callBack: @escaping () -> Void,
        failure: @escaping (_ error: String) -> Void)
    {
        Network.requestObject(request: Router.apodDate(date: date), type: Apod.self, completion: { result in
            switch result {
            case .success(let data):
                self.apod = data
                callBack()
            case .failure(let error):
                failure(error.localizedDescription)
            }
        })
    }
    
    
    // Add contact
    func addApod(apod: ApodObject,
                 callBack: @escaping () -> Void,
                 failure: @escaping (_ error: String) -> Void)
    {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(apod)
                callBack()
            }
        } catch let error {
            failure(error.localizedDescription)
        }
    }
    
    func checkApodSave(
        date: String)
    {
        let item =  apodList.filter("date = '\(date)'").first
        if item != nil {
            self.isSaved = true
        }
    }
    
    func removeApod(
        date: String,
        callBack: @escaping () -> Void,
        failure: @escaping (_ error: String) -> Void)
    {
        do {
            let realm = try Realm()
            let item =  realm.objects(ApodObject.self).filter("date = '\(date)'").first
            if item != nil {
                let objectId = item!.id
                if let apod = realm.object(ofType: ApodObject.self, forPrimaryKey: objectId) {
                    try realm.write {
                        realm.delete(apod)
                        callBack()
                    }
                }
            }
        } catch let error {
            failure(error.localizedDescription)
        }
    }
}
