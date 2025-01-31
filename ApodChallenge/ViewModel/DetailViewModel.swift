//
//  DetailViewModel.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var apod: Apod = Apod()
    
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
}
