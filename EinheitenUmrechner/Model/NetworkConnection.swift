//
//  NetworkConnection.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 22.02.25.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    let networkMonitor = NWPathMonitor()
    let workerQueue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected = true
    
    init() {
        networkMonitor.pathUpdateHandler = {path in
//            self.isConnected = path.status == .satisfied
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
