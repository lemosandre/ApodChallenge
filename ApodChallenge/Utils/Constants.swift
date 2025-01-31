//
//  Constants.swift
//  APOD
//
//  Created by Andre Lemos on 2025-01-29.
//

import Foundation

struct API {
    static let nasaURL = "https://api.nasa.gov"
    struct Path {
        static let nasaAPOD = "/planetary/apod/"
    }
    
    struct DefaultValue {
        static let timeOut = 60.00
        static let notFoundImageURL = "https://cdn1.polaris.com/globalassets/pga/accessories/my20-orv-images/no_image_available6.jpg?v=71397d75&format=webp&height=800"
        static let key = "api_key"
        static let startDate = "start_date"
        static let endDate = "end_date"
        static let date = "date"
        static let playVideoImade = "https://play-lh.googleusercontent.com/LsmwRk16eEuZXxYLc-FGARu72Ji1qQq3Ow5d0aQ6tX2JE_yAFwRVx0Ubuv5rWuhNnSEa=w240-h480"
        static let dateFormat = "yyyy-MM-dd"
    }
    
    struct Headers {
        static let applicationJson = "application/json"
        static let contentType = "Content-Type"
        static let nasaKey = "KdsPneLp0EGpNWZuwb1CyVvruyz8lfDqyYVPi4Pv"
    }
}
