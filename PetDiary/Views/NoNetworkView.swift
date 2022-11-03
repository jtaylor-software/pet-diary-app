//
//  NoNetworkView.swift
//  PetDiary
//
//  Created by Jeremy Taylor on 10/26/22.
//

import SwiftUI

struct NoNetworkView: View {
    let message = """
        No Network Connection!
        We'll keep checking for connectivity.
        """
    @EnvironmentObject var network: NetworkMonitor
    var body: some View {
        NavigationView {
            VStack {
                Text(message)
                NavigationLink(destination: SplashScreen(), isActive: $network.isActive) {
                    Text("")
                    
                }
            }
        }
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
    }
}
