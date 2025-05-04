//
//  NetworkMonitor.swift
//  Day2 swift
//
//  Created by Kerolos on 04/05/2025.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isConnected: Bool { status == .satisfied }
    
    private init() {
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            NotificationCenter.default.post(
                name: path.status == .satisfied ? .networkConnected : .networkDisconnected,
                object: nil
            )
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let networkConnected = Notification.Name("NetworkConnected")
    static let networkDisconnected = Notification.Name("NetworkDisconnected")
}
