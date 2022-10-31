//
//  NetworkMonitor.swift
//  PetDairy
//
//  Created by Jeremy Taylor on 10/26/22.
//

import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
    var isActive = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isActive = path.status == .satisfied
            Task { @MainActor in
                self.objectWillChange.send()
            }
            
        }
        
        monitor.start(queue: queue)
    }
}

