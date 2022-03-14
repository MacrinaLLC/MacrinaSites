//
//  MacrinaHTMLFactory.swift
//  
//
//  Created by jarwarren on 3/13/22.
//

import Plot
import Publish

public struct MacrinaHTMLFactory<Site: Website>: HTMLFactory {
    private var sections: [MacrinaSections] { MacrinaSections.allCases }
    public func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        makeHTML(for: 0, language: context.site.language)
    }
    
    public func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        makeHTML(
            for: (section.id as? MacrinaSections)?.index ?? 0,
               language: context.site.language
        )
    }
    
    public func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        filler("Item")
    }
    
    public func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        filler("Page")
    }
    
    public func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
    
    public func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        nil
    }
    
    private func filler(_ text: String) -> HTML {
        HTML {
            Text(text)
        }
    }
    
    private func makeHTML(for index: Int, language: Language) -> HTML {
        HTML(
            .lang(language),
            .head(
                .stylesheet("/air.css"),
                .favicon("/favicon.ico", type: "image/ico"),
                .meta(.charset(.utf8)),
                .meta(
                    .name("viewport"),
                    .attribute(named: "content", value: "width=device-width, initial-scale=1")
                )
            ),
            .body(
                .header(
                    .h1("\(sections[index].page.title)")
                ),
                .component(
                    TopNavigation(currentIndex: index, pages: sections.map(\.page))
                ),
                .component(
                    sections[index]
                        .page
                        .body
                        .style("padding: 24px;")
                ),
                .component(
                    sections[index]
                        .page
                        .footer ?? SiteFooter()
                )
            )
        )
    }
}
