# MacrinaSites
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)
[![Swift 5.5](https://img.shields.io/badge/swift-5.5-orange.svg?style=flat)](https://forums.swift.org)

### Description
MacrinaSites is a small Swift Package built on top of [Publish](https://github.com/JohnSundell/Publish).

### Installation
1. Make sure that Publish is installed. The easiest way is with Homebrew.
```
brew install publish
```
2. Create an empty folder with the name of your website.
3. Inside of the folder run the following script.
```
curl -s https://raw.githubusercontent.com/MacrinaLLC/MacrinaSites/master/setup.sh | bash
```
4. Add MacrinaSites as a dependency to your `Package.swift` file and `"MacrinaSites"` to the array of dependencies.
```
.package(name: "MacrinaSites", url: "https://github.com/MacrinaLLC/MacrinaSites.git", .branch("master"))
```
5. Whenever you're ready, use `publish run` to generate your website in the `Output` folder. If needed, more detailed instructions can be found on the Publish readme.
### Acknowledgements
- [Publish](https://github.com/JohnSundell/Publish) by John Sundell
- [Air.css](https://github.com/JarWarren/air) by John Otander
