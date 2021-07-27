//
//  NetworkManager.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 26.07.2021.
//

import Network

class NetworkManager {
    
    static let shared = NetworkManager()
    
    lazy private var monitor = NWPathMonitor()

    private init() { }

    public func checkInternetConnection(onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            DispatchQueue.main.async {
                if pathUpdateHandler.status == .satisfied {
                    onSuccess()
                } else {
                    onError(AppLocalization.text(.INTERNET_CONNECTION_ERROR_TEXT))
                }
            }
        }
        let queue = DispatchQueue(label: AppLocalization.text(.INTERNET_CONNECTION_QUEUE_LABEL_STRING))
        monitor.start(queue: queue)
    }
    
    public func cancelMonitoring() {
        monitor.cancel()
    }
}
