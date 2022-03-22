#!/usr/bin/swift
import Foundation
import Dispatch

struct Command {
    let arguments: String
    let description: String
}

extension Process {
    static func execute(_ command: Command) throws {
        currentStep += 1
        print(TerminalColors.blue + "[\(currentStep)/\(totalSteps)] " + TerminalColors.default + command.description)
        let process = Process()
        process.launchPath = "/bin/bash"
        process.arguments = ["-c", command.arguments]
        let outputHandle = FileHandle.standardOutput
        let errorHandle = FileHandle.standardError
        
        let outputQueue = DispatchQueue(label: "bash-output-queue")
        
        var outputData = Data()
        var errorData = Data()
        
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        
        let errorPipe = Pipe()
        process.standardError = errorPipe
        
        outputPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                outputData.append(data)
                outputHandle.write(data)
            }
        }
        
        errorPipe.fileHandleForReading.readabilityHandler = { handler in
            let data = handler.availableData
            outputQueue.async {
                errorData.append(data)
                errorHandle.write(data)
            }
        }
        
        process.launch()
        process.waitUntilExit()
        
        outputPipe.fileHandleForReading.readabilityHandler = nil
        errorPipe.fileHandleForReading.readabilityHandler = nil
        
        try outputQueue.sync {
            if process.terminationStatus != 0 {
                throw SetupError(
                    errorDescription:
                        """
                        Termination Status: \(TerminalColors.red)\(process.terminationStatus)\(TerminalColors.default)
                        Error: \(TerminalColors.red)\(errorData.humanReadable)
                        Output: \(TerminalColors.blue)\(outputData.humanReadable)\(TerminalColors.default)
                        """
                )
            }
        }
    }
}

struct SetupError: LocalizedError {
    var errorDescription: String?
}

enum TerminalColors {
    static var blue: String { "\u{001b}[36m" }
    static var `default`: String { "\u{001b}[0m" }
    static var green: String { "\u{001b}[32m" }
    static var pink: String { "\u{001b}[35m" }
    static var red: String { "\u{001b}[31m" }
}

extension Data {
    var humanReadable: String {
        String(data: self, encoding: .utf8) ?? "None"
    }
}

func downloadCSS(completion: @escaping (Result<Void, Error>) -> Void) {
    print("Downloading \(TerminalColors.green)air.css\(TerminalColors.default) to Resources/")
    guard let url = URL(string: "https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/master/air.css") else {
        return completion(.failure(SetupError(errorDescription: "Invalid URL for css")))
    }
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            completion(.failure(error))
        }
        guard let data = data else {
            return completion(.failure(SetupError(errorDescription: "Unable to locate CSS")))
        }
        
        guard let currentDirectory = Process().currentDirectoryURL else {
            return completion(.failure(SetupError(errorDescription: "Unable to save css")))
        }
        let targetDirectory = currentDirectory
            .appendingPathComponent("Resources")
            .appendingPathComponent("air")
            .appendingPathExtension("css")
        do {
            try data.write(to: targetDirectory)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }.resume()
    RunLoop.main.run(until: Date() + 3)
}

func downloadSwiftLogo(completion: @escaping (Result<Void, Error>) -> Void) {
    print("Downloading \(TerminalColors.green)swift-logo.webp\(TerminalColors.default) to Resources/")
    guard let url = URL(string: "https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/master/swift-logo.webp") else {
        return completion(.failure(SetupError(errorDescription: "Invalid URL for image")))
    }
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            completion(.failure(error))
        }
        guard let data = data else {
            return completion(.failure(SetupError(errorDescription: "Unable to locate image")))
        }
        
        guard let currentDirectory = Process().currentDirectoryURL else {
            return completion(.failure(SetupError(errorDescription: "Unable to save image")))
        }
        let targetDirectory = currentDirectory
            .appendingPathComponent("Resources")
            .appendingPathComponent("swift-logo")
            .appendingPathExtension("webp")
        do {
            try data.write(to: targetDirectory)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }.resume()
    RunLoop.main.run(until: Date() + 3)
}

func failure(_ error: Error) {
    print("⛔️ Error: " + error.localizedDescription)
}

func downloadTemplate(completion: @escaping (Result<Void, Error>) -> Void) {
    print("Downloading \(TerminalColors.green)main.swift\(TerminalColors.default) template to Sources/\(currentDirectoryName)/")
    guard let url = URL(string: "https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/master/Template.swift") else {
        return completion(.failure(SetupError(errorDescription: "Invalid URL for template")))
    }
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            completion(.failure(error))
        }
        guard let data = data else {
            return completion(.failure(SetupError(errorDescription: "Unable to locate template")))
        }
        
        guard let currentDirectory = Process().currentDirectoryURL else {
            return completion(.failure(SetupError(errorDescription: "Unable to save template")))
        }
        let targetDirectory = currentDirectory
            .appendingPathComponent("Sources")
            .appendingPathComponent(currentDirectoryName)
            .appendingPathComponent("main")
            .appendingPathExtension("swift")
        do {
            try data.write(to: targetDirectory)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }.resume()
    RunLoop.main.run(until: Date() + 3)
}

var currentStep = 0
let totalSteps = 7
var currentDirectoryName: String = {
    FileManager
        .default
        .currentDirectoryPath
        .split(separator: "/")
        .map(String.init)
        .last ?? ""
}()

let commands = [
    Command(
        arguments: "publish new",
        description: "Generating source files with \(TerminalColors.pink)publish new\(TerminalColors.default)."
    ),
    Command(
        arguments: "rm -rf Content",
        description: "Deleting Content directory"
    ),
    Command(
        arguments: "mkdir Content",
        description: "Recreating Content directory"
    ),
    Command(
        arguments: "touch empty",
        description: "Making placeholder file"
    ),
    Command(
        arguments: "mv empty Content/empty",
        description: "Moving placeholder to Content directory"
    ),
]

let deleteTemplate = Command(
    arguments: "rm Sources/\(currentDirectoryName)/main.swift",
    description: "Deleting original website template"
)

print("\nSetting up your Website")
do {
    for command in commands {
        try Process.execute(command)
    }
    downloadCSS { result in
        do {
            try result.get()
            try Process.execute(deleteTemplate)
            downloadTemplate { result in
                do {
                    try result.get()
                    downloadSwiftLogo { result in
                        do {
                            try result.get()
                            print("\(TerminalColors.blue)[\(totalSteps)/\(totalSteps)]\(TerminalColors.default) Wrapping up...")
                        } catch {
                            failure(error)
                        }
                    }
                } catch {
                    failure(error)
                }
            }
        } catch {
            failure(error)
        }
    }
} catch {
    failure(error)
}

print(
"""
✅ Success!

------------------------
⚠️   Remember to add MacrinaSites as a dependency to your \(TerminalColors.green)Package.swift\(TerminalColors.default)

\(TerminalColors.blue).package(name: "MacrinaSites", url: "https://github.com/MacrinaLLC/MacrinaSites.git", .branch("master"))\(TerminalColors.default)

⚠️   Add \(TerminalColors.blue)"MacrinaSites"\(TerminalColors.default) to the array of dependencies as well!
------------------------

Afterwards, use \(TerminalColors.pink)publish run\(TerminalColors.default) to test out your website.
"""
)
