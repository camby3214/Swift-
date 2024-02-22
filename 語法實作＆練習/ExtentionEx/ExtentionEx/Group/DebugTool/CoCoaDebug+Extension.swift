//
//  CoCoaDebuf+PGTalkCore.swift
//  PGTalkLiteProvingGround
//
//  Created by 呂子揚 on 2022/5/6.
//

import Foundation
#if DEBUG
import CocoaDebug
#endif
import MatrixSDK
import UIKit
typealias PrintAlias = ( level: String, emojiStr: String, textColor: UIColor)
/**
 - emoji source: https://emojipedia.org/police-car-light/
 - Define verbose log:
 https://www.sentinelone.com/blog/verbose-logging-bad-application-behavior-2/
 
 */
/**
- CocoaDebugTool.verbose("A verbose message, usually useful when working on a specific problem")
- CocoaDebugTool.debug("A debug message")\n
- CocoaDebugTool.info("An info message, probably useful to power users looking in console.app")
- CocoaDebugTool.notice("A notice message")
- CocoaDebugTool.warning("A warning message, may indicate a possible
- CocoaDebugTool.error("An error occurred, but it's recoverable, just info about what
- CocoaDebugTool.severe("A severe error occurred, we are likely about to crash
- CocoaDebugTool.alert("An alert error occurred, a log destination could be made to email
- CocoaDebugTool.emergency("An emergency error occurred, a log destination could be made to text
 
 */
enum PrintLevel {
    case verbose ( printAlias: PrintAlias = ( "[VERBOSE]", "🤔", .lightGray))
    case debug ( printAlias: PrintAlias = ( "[DEBUG]", "🛠️", .green))
    case info ( printAlias: PrintAlias = ( "[INFO]", "📝", .cyan))
    case notice ( printAlias: PrintAlias = ( "[NOTICE]", "📌", .darkGray))
    case warning ( printAlias: PrintAlias = ( "[WARNINCE]", "⚠️", .yellow))
    
    case error ( printAlias: PrintAlias = ( "[ERROR]", "🚨1️⃣", .red))
    case severe ( printAlias: PrintAlias = ( "[SEVERE]", "🚨2️⃣", .red))
    case alert ( printAlias: PrintAlias = ( "[ALERT]", "🚨3️⃣", .red))
    case emergency ( printAlias: PrintAlias = ( "[EMERGENCY]", "🚨4️⃣", .red))
    
}

#if DEBUG
extension CocoaDebugTool {
 
    
    static private func sortString(content: String, message: String, emojiStr: String, levelStr: String) -> String {
        var output = String()
        let emojis = "\(emojiStr)\(emojiStr)"
        
        if message != nomessage {
            output = emojis + levelStr + content + emojis
        } else {
            output = emojis + levelStr + message + content + emojis
        }
        return output
    }
    private static let nomessage = ""

    static private func getLogSympolOutput( printType: PrintLevel, onlyFileName: String, message: String, lineNumber: Int) -> ( printText: String, textColor: UIColor) {
        var returnValue = (String(), UIColor())
        let content = ", \(onlyFileName)[\(lineNumber)]"
       
        switch printType {
            
        case .verbose(printAlias: let logSympol): fallthrough
        case .debug(printAlias: let logSympol): fallthrough
        case .info(printAlias: let logSympol): fallthrough
        case .notice(printAlias: let logSympol): fallthrough
        case .warning(printAlias: let logSympol): fallthrough
        case .error(printAlias: let logSympol): fallthrough
        case .severe(printAlias: let logSympol): fallthrough
        case .alert(printAlias: let logSympol): fallthrough
        case .emergency(printAlias: let logSympol):
            returnValue =  (sortString(content: content, message: message, emojiStr: logSympol.emojiStr, levelStr: logSympol.level), logSympol.textColor)
            
        }
        return returnValue
    }
    /**
    Usage:
     _ = CocoaDebugTool.print(printLevel: .alert())
     */
    static func printIt(printLevel: PrintLevel, message: String = CocoaDebugTool.nomessage, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) -> String {
        guard let onlyFileName = fileName.description.components(separatedBy: "/").last?.components(separatedBy: ".").first else {return String()}
        
        let output = getLogSympolOutput(printType: printLevel.self, onlyFileName: onlyFileName, message: message, lineNumber: lineNumber)
        
        
        
        CocoaDebugTool.log(with: output.printText, color: output.textColor)
        guard userInfo.isEmpty == false else { return output.printText }
       
        do {
            let data = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
            CocoaDebugTool.log(with: CocoaDebugTool.log(withJsonData: data), color: output.textColor)
            MXLog.debug(message)
            return CocoaDebugTool.log(withJsonData: data)
        } catch {
            let catchOutput = getLogSympolOutput(printType: printLevel.self, onlyFileName: onlyFileName, message: error.localizedDescription, lineNumber: lineNumber)
            CocoaDebugTool.log(with: catchOutput.printText, color: catchOutput.textColor)
            MXLog.debug(message)
            return "catch error"

        }
        
    }
    
}

#endif

extension NSString {
    static func cocoaDebugString(languageCodeString:String) {
        #if DEBUG
        _ = CocoaDebugTool.printIt(printLevel: .debug(), message: "沒有該多國語系, strings file name: pgtalk_\(languageCodeString)")
        #endif
        
    }
}
