import Foundation

public protocol CommentsAssembly: class {
    func createComments(memeId: String) -> PresentationViewModule<CommentsModule>
}

final public class CommentsAssemblyImpl: Assembly, CommentsAssembly {
    // MARK: - FeedAssembly
    public func createComments(memeId: String) -> PresentationViewModule<CommentsModule> {
        
        let presenter = CommentsPresenter(
            memeId: memeId,
            сommentsService:serviceFactory.commentsService()
        )
        
        let viewController = CommentsViewController(
            viewOutput: presenter
        )
        
        presenter.view = viewController
        presenter.router = CommentsRouterImpl(
            rootViewController: viewController,
            moduleFactory: moduleFactory
        )
        
        return PresentationViewModule(
            interface: presenter,
            view: viewController
        )
    }
}
