//
//  String+Utils.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 21/11/2018.
//

import Foundation

enum FileWriteError: Error
{
    case directoryDoesntExist
    case convertToDataIssue
}

func write(_ text: String, toFilename filename: String) throws
{
    guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        throw FileWriteError.directoryDoesntExist
    }
    
    let encoding = String.Encoding.utf8
    
    guard let data = text.appending("\n").data(using: encoding) else {
        throw FileWriteError.convertToDataIssue
    }
    
    let fileUrl = dir.appendingPathComponent(filename)
    
    if let fileHandle = FileHandle(forWritingAtPath: fileUrl.path) {
        fileHandle.seekToEndOfFile()
        fileHandle.write(data)
    } else {
        try text.write(to: fileUrl, atomically: false, encoding: encoding)
    }
}

func read(filename: String) throws -> String
{
    guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        throw FileWriteError.directoryDoesntExist
    }
    
    let fileUrl = dir.appendingPathComponent(filename)
    return try String(contentsOfFile: fileUrl.path)
}
