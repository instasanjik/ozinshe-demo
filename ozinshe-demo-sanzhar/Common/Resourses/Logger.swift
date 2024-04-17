//
//  Logger.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 10.03.2024.
//

import Foundation

enum LogType: String {
    case error
    case warning
    case success
    case action
    case canceled
    case info
}

public class OZLogger {
    
    static func log(_ logType:LogType, _ message: Any) {
        switch logType {
        case LogType.info:
            guard SHOULD_PRINT else { return }
            print("\(Date.dateTime) - 📓 Info: \(message)\n")
        case LogType.error:
            print("\(Date.dateTime) - 📕 Error: \(message)\n")
        case LogType.warning:
            print("\(Date.dateTime) - 📙 Warning: \(message)\n")
        case LogType.success:
            guard SHOULD_PRINT else { return }
            print("\(Date.dateTime) - 📗 Success: \(message)\n")
        case LogType.action:
            guard SHOULD_PRINT else { return }
            print("\(Date.dateTime) - 📘 Action: \(message)\n")
        case LogType.canceled:
            guard SHOULD_PRINT else { return }
            print("\(Date.dateTime) - 📓 Cancelled: \(message)\n")
        }
    }
    
    
}

public let Logger = OZLogger.self
