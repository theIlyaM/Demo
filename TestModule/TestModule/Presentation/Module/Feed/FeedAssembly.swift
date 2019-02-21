import Foundation

public protocol FeedAssembly: class {
    func createFeed(settings: FeedViewControllerSettings) -> PresentationViewModule<FeedModule>
}

final public class FeedAssemblyImpl: Assembly, FeedAssembly {
    // MARK: - FeedAssembly
    public func createFeed(settings: FeedViewControllerSettings) -> PresentationViewModule<FeedModule> {
        let presenter = FeedPresenter(
            feedService:serviceFactory.feedService()
        )
        
        let viewController = FeedViewController(
            viewOutput: presenter,
            settings: settings
        )
        
        presenter.view = viewController
        presenter.router = FeedRouterImpl(
            rootViewController: viewController,
            moduleFactory: moduleFactory
        )
        
        return PresentationViewModule(
            interface: presenter,
            view: viewController
        )
    }
}
