import Foundation

public protocol CommentsAssembly: class {
    func createComments(memeId: String) -> PresentationViewModule<CommentsModule>
}

final public class CommentsAssemblyImpl: CommentsAssembly {
    let commentService: CommentsService
    
    init(commentService: CommentsService) {
        self.commentService = commentService
    }
    
    // MARK: - FeedAssembly
    public func createComments(memeId: String) -> PresentationViewModule<CommentsModule> {
        
        let presenter = CommentsPresenter(
            memeId: memeId,
            сommentsService:self.commentService
        )
        
        let viewController = CommentsViewController(
            viewOutput: presenter
        )
        
        presenter.view = viewController
        presenter.router = CommentsRouterImpl(
            rootViewController: viewController
        )
        
        return PresentationViewModule(
            interface: presenter,
            view: viewController
        )
    }
}
