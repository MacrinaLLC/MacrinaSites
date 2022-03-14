//
//  MacrinaSites.swift
//
//
//  Created by jarwarren on 3/13/22.
//

import Foundation
import Plot
import Publish

public protocol MacrinaPage: Component {
    /// User-facing name of the webpage.
    var title: String { get }
    /// Path to the webpage. Ex. `"/contact"`
    var path: String { get }
    /// The webpage.
    var body: Component { get }
    /// What appears at the bottom of the page. If no footer is provided, defaults to "Built in Swift using Publish."
    var footer: Component? { get }
}

public protocol MacrinaWebsite {
    /// The absolute URL that the website will be hosted at.
    var url: URL { get }
    /// The name of the website.
    var name: String { get }
    /// A description of the website.
    var description: String { get }
    /// The website's primary language.
    var language: Language { get }
    /// Any path to an image that represents the website.
    var imagePath: Path? { get }
    /// The website's favicon, if any.
    var favicon: Favicon? { get }
    /// Primary content of the website. Each page is given a link at the top of the website.
    var pages: [MacrinaPage] { get }
}

public extension MacrinaWebsite {
    var language: Language { .usEnglish }
    func publish(file: StaticString = #file) throws {
        MacrinaSections.allCases = pages
            .enumerated()
            .compactMap(PublishWebsite.SectionID.init)
        guard let containingFolder = URL(string: "\(file)") else { throw MacrinaError.unableToLocateRootFolder }
        let root = containingFolder
           .deletingPathExtension()
           .deletingLastPathComponent()
           .deletingLastPathComponent()
           .deletingLastPathComponent()
        try PublishWebsite(website: self)
            .publish(
                withTheme: .macrina,
                at: Path(root.absoluteString)
            )
    }
}

enum MacrinaError: LocalizedError {
    case unableToLocateRootFolder
    var errorDescription: String? {
        switch self {
        case .unableToLocateRootFolder:
            return "Unable to locate the root folder."
        }
    }
}

private extension Theme {
    static var macrina: Theme {
        Theme(htmlFactory: MacrinaHTMLFactory())
    }
}

private struct PublishWebsite: Website {
    var url: URL { website.url }
    var name: String { website.name }
    var description: String { website.description }
    var language: Language { website.language }
    var imagePath: Path? { website.imagePath }
    var favicon: Favicon? { website.favicon }
    let website: MacrinaWebsite
    
    typealias SectionID = MacrinaSections
    struct ItemMetadata: WebsiteItemMetadata { }
}

struct MacrinaSections: WebsiteSectionID {
    static var allCases: [MacrinaSections] = []
    var rawValue: String
    var index: Int!
    var page: MacrinaPage!
    init?(rawValue: String) {
        self.rawValue = rawValue
    }
    init?(index: Int, page: MacrinaPage) {
        self.init(rawValue:page.path)
        self.page = page
        self.index = index
    }
}
