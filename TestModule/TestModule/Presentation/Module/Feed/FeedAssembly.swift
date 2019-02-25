import Foundation

public protocol FeedAssembly: class {
    func createFeed(settings: FeedViewControllerSettings) -> PresentationViewModule<FeedModule>
}

final public class FeedAssemblyImpl: FeedAssembly {
    let feedService: FeedService
    let commentsAssembly: CommentsAssembly
    
    
    init(feedService: FeedService, commentsAssembly: CommentsAssembly) {
        self.feedService = feedService
        self.commentsAssembly = commentsAssembly
    }
    
    // MARK: - FeedAssembly
    public func createFeed(settings: FeedViewControllerSettings) -> PresentationViewModule<FeedModule> {
        let presenter = FeedPresenter(
            feedService:feedService
        )
        
        let viewController = FeedViewController(
            viewOutput: presenter,
            settings: settings
        )
        
        presenter.view = viewController
        presenter.router = FeedRouterImpl(
            commentsAssembly: commentsAssembly,
            rootViewController: viewController
        )
        
        return PresentationViewModule(
            interface: presenter,
            view: viewController
        )
    }
}
