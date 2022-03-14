import Foundation
import Publish
import Plot
import MacrinaSites

// This type acts as the configuration for your website.
struct HelloWorld: MacrinaWebsite {

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "HelloWorld"
    var description = "A description of HelloWorld"
    var language: Language { .english }
    var imagePath: Path? { nil }
    var favicon: Favicon?
    var pages: [MacrinaPage] {
        [
        Home(),
        About(),
        Contact()
        ]
    }
}

// This will generate your website using the built-in Foundation theme:
try HelloWorld().publish()


struct Home: MacrinaPage {
    var title: String = "Home"
    var path: String = "/"
    var body: Component {
        Text("Hello, World")
    }
    var footer: Component?
}

struct About: MacrinaPage {
    var title: String = "About"
    var path: String = "/about"
    var body: Component {
        Text("Hello, About")
    }
    var footer: Component?
}

struct Contact: MacrinaPage {
    var title: String = "Contact"
    var path: String = "/contact"
    var body: Component {
        Text("Hello, Contact")
    }
    var footer: Component?
}
