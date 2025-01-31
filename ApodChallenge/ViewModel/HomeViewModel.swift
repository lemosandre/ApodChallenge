//
//  HomeViewModel.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var apodList: [Apod] = []
    
    func getApod(
        callBack: @escaping () -> Void,
        failure: @escaping (_ error: String) -> Void)
    {
        Network.requestObject(request: Router.apod, type: Apod.self, completion: { result in
            switch result {
            case .success(let data):
                self.apodList.removeAll()
                self.apodList.append(data)
                callBack()
            case .failure(let error):
                failure(error.localizedDescription)
            }
        })
    }
    
    func getApodList(
        startDate: String,
        endDate: String,
        callBack: @escaping () -> Void,
        failure: @escaping (_ error: String) -> Void)
    {
        Network.requestArray(request: Router.apodList(startDate: startDate, endDate: endDate), type: Apod.self, completion: { result in
            switch result {
            case .success(let data):
                self.apodList.removeAll()
                data.forEach { item in
                    self.apodList.append(item)
                }
                callBack()
            case .failure(let error):
                failure(error.localizedDescription)
            }
        })
    }
}
