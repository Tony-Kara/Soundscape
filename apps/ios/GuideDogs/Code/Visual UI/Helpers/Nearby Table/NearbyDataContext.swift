//
//  NearbyDataContext.swift
//  Soundscape
//
//  Copyright (c) Microsoft Corporation.
//  Licensed under the MIT License.
//

import Foundation
import CoreLocation
import Combine

class NearbyDataContext {
    
    enum NearbyError: Error {
        case missingLocation
        case offline
        case requestFailed
    }
    
    typealias NearbyResult = Result<[POI], NearbyError>
    
    // MARK: Properties
    
    private(set) var location: CLLocation?
    private var initialNearbyRequestToken: RequestToken?
    private let queue = DispatchQueue(label: "com.company.appname.nearbytable")
    private var pois: [POI] = []
    private(set) var data: CurrentValueSubject<NearbyData, NearbyError>
    private(set) var isLoading = false
    private var didPresentErrorAlert = false
    
    // MARK: Initialization
    
    init(location: CLLocation) {
        self.location = location
        
        let initialDataValue = NearbyData(pois: [], filters: NearbyTableFilter.primaryTypeFilters)
        data = .init(initialDataValue)

        let dataView = fetchNearbyData()
        
        if let dataView = dataView {
            pois = dataView.pois
        }
        
        data.send(NearbyData(pois: pois, filters: NearbyTableFilter.defaultFilters))
    }

    private func fetchNearbyData() -> SpatialDataViewProtocol? {
        if self.location == CLLocation.sample {
            return AppContext.shared.spatialDataContext.fetchSamplePOIs()
        } else {
            return AppContext.shared.spatialDataContext.getCurrentDataView { (dataView) -> Bool in
                return dataView.pois.count < 100
            }
        }
    }
}
