//
//  CallView.swift
//  SharedUIIOS
//
//  Created by Tio Fani on 16/03/26.
//
import SwiftUI
import Shared

public enum CallStatus: String {
    case connecting = "Connecting"
}

public struct CallView: View {
    
    public var callStatus: CallStatus = .connecting

    public init() {}

    public var body: some View {
        Text(Greeting().greet())
        Text(callStatus.rawValue)
    }
}

