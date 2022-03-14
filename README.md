# MacrinaSites
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)
[![Swift 5.5](https://img.shields.io/badge/swift-5.5-orange.svg?style=flat)](https://forums.swift.org)

### Description
MacrinaSites is a small Swift Package built on top of [Publish](https://github.com/JohnSundell/Publish).
All of the sites I make tend to follow a similar style, and it becomes tedius to write the same code over and over.
This little package is a quick way to set up a website in the same style as the others.

### Examples
- Macrina Website - [link](https://macrina.tech)
- JarWarren - [link](https://jarwarren.github.io)

### Installation
1. Make sure that Publish is installed. The easiest way is with Homebrew.
```
brew install publish
```
2. Create an empty folder with the name of your website.
3. Inside of the folder run `publish new`.
4. Add MacrinaSites as a dependency to your `Package.swift` file.
```
.package(name: "MacrinaSites", url: "https://github.com/MacrinaLLC/MacrinaSites.git", .branch("master"))
```
5. In the same, root folder of your project, run the following script to generate a template and add css to your project.
```
todo
```
### Acknowledgements
- [Publish](https://github.com/JohnSundell/Publish) by John Sundell
- [Air.css](https://github.com/JarWarren/air) by John Otander
