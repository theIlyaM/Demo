import Foundation

public enum CommentsModuleFinishState {
    case removeComment(Comment)
}

public protocol CommentsModule: class {
    var onFinished: Closure.Argument<CommentsModuleFinishState>? { get set }
}

final public class CommentsPresenter: CommentsModule, CommentsViewOutput {    
    // MARK: - Private properties
    private let memeId: String
    private let сommentsService: CommentsService
    
    // MARK: - Public properties
    public var router: CommentsRouter?
    public weak var view: CommentsViewInput?
    
    // MARK: - Init
    public init(
        memeId: String,
        сommentsService: CommentsService)
    {
        self.memeId = memeId
        self.сommentsService = сommentsService
    }
    
    // MARK: - CommentsModule
    public var onFinished: Closure.Argument<CommentsModuleFinishState>?
    
    // MARK: - CommentsViewOutput
    public func onViewDidLoad() {
        view?.startAnimating()
    }
    
    public func onViewWillAppear() {
        сommentsService.loadComments(memeId: memeId) { [weak self] comments in
            self?.view?.stopAnimating()
            self?.showComments(comments)
        }
    }
    
    // MARK: - Private
    private func showComments(_ comments: [Comment]) {
        view?.setViewData(
            CommentsViewData(
                comments: comments,
                removeButtonTitle: comments.count > 0 ? "Удалить последний комментарий" : nil,
                onRemoveTap: { [weak self] in
                    self?.askToRemoveComment(comments.last)
                }
            )
        )
    }
    
    private func askToRemoveComment(_ comment: Comment?) {
        guard let comment = comment else { return }
        
        view?.showAlertWithTitle("Удалить и закрыть?", buttonTitle: "Да") { [weak self] in
            self?.сommentsService.removeComment(commentId: comment.id) { [weak self] in
                self?.onFinished?(.removeComment(comment))
                self?.router?.close()
            }
        }
    }
}
