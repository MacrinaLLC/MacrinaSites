import Foundation
import Publish
import Plot
import MacrinaSites

// This type acts as the configuration for your website.
struct HelloWorld: MacrinaWebsite {

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "Hello World"
    var description = "A description of Hello World"
    var language: Language = .usEnglish
    var favicon: Favicon?
    // Path to the image that represents your website
    var imagePath: Path?
    
    // Pass one or more pages to this array. If it receives two or more, a navigation bar will be generated at the top of each page.
    var pages: [MacrinaPage] = [
        Home(),
        About(),
        Contact()
    ]
}

// This will generate your website using the built-in Foundation theme:
try HelloWorld().publish()


// MARK: Sample Pages

struct Home: MacrinaPage {
    var title: String = "Home"
    var path: String = "/"
    var body: Component {
        Div {
            MacrinaImage("swift-logo.webp", style: .circle)
        }
    }
    var footer: Component?
}

struct About: MacrinaPage {
    var title: String = "About"
    var path: String = "/about"
    var body: Component {
        Div {
            H2("About Me")
            Paragraph("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            Divider()
            Image("swift-logo.webp")
            Divider()
            H2("More About Me")
            Paragraph("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        }
    }
    var footer: Component? {
        Footer {
            Div {
                Text("A custom footer ")
                MacrinaImage("swift-logo.webp", style: .icon)
            }
        }
    }
}

struct Contact: MacrinaPage {
    var title: String = "Contact"
    var path: String = "/contact"
    var body: Component {
        Div {
            Text("Link to my ")
            Link("Website", url: "/")
        }
    }
    var footer: Component?
}
