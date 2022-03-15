//
//  Components.swift
//  
//
//  Created by jarwarren on 3/13/22.
//

import Foundation
import Plot

/// An Image with custom CSS styling.
public struct MacrinaImage: Component {
    let name: String
    let style: ImageStyle
    
    public init(_ name: String, style: ImageStyle) {
        self.name = name
        self.style = style
    }
    
    public var body: Component {
        Image(name)
            .class(style.rawValue)
    }
    
    public enum ImageStyle: String {
        /// 200 x 200 circular image
        case circle
        /// 120 x 120 square image
        case logo
        /// 16 x 16 icon image
        case icon
    }
}

/// Swift wrapper for the horizontal row `<hr>` HTML tag.
public struct Divider: Component {
    var width: Int?
    public var body: Component {
        if let width = width {
            return Element(name: "hr", content: {})
                .attribute(named: "width", value: String(width))
        } else {
            return Element(name: "hr", content: {})
        }
    }
}
/// Swift wrapper for the horizontal row `<hr>` HTML tag.
public typealias HorizontalRow = Divider

/// Swift wrapper for the linbreak `<br>` HTML tag.
public struct LineBreak: Component {
    public var body: Component {
        Element(name: "br", content: {})
    }
}

 struct SiteFooter: Component {
    var body: Component {
        Footer {
            Div {
                Text("Built in Swift using ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
                Text(".")
            }
        }
    }
}

struct TopNavigation: Component {
    let currentIndex: Int
    let pages: [MacrinaPage]
    var body: Component {
        Div {
            if pages.count > 1 {
                link(to: 0)
                for index in 1..<pages.count {
                    separator
                    link(to: index)
                }
                HorizontalRow(width: 120)
            }
        }
    }
    
    var separator: Component {
        Text(" · ")
    }
    
    func link(to index: Int) -> Component {
        let page = pages[index]
        if index == currentIndex {
            return Text(page.title)
        } else {
            return Link(page.title, url: page.path)
        }
    }
}
