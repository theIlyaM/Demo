import Foundation

public protocol FeedModule: class {
    
}

final public class FeedPresenter: FeedModule, FeedViewOutput {
    // MARK: - Private properties
    private let feedService: FeedService
    
    // MARK: - Public properties
    public var router: FeedRouter?
    public weak var view: FeedViewInput?
    
    // MARK: - Init
    public init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    // MARK: - FeedModule
    
    // MARK: - FeedViewOutput
    public func onViewDidLoad() {
        view?.setTitle("Feed")
        view?.setButtonViewData(.loading)
    }
    
    public func onViewWillAppear() {
        feedService.loadFeed { [weak self] meme in
            self?.view?.setButtonViewData(
                .data(
                    title: "Перейти в комментарии (id: \(meme.id))",
                    onTap: { [weak self] in
                        self?.showComments(memeId: meme.id)
                    }
                )
            )
        }
    }
    
    public func onLeftBarButtonItemTap() {
        router?.close()
    }
    
    public func onRightBarButtonItemTap() {
        // As example to simulate sending push notifications from server
        let key = "isAlertShown"
        
        if UserDefaults.standard.bool(forKey: key) {
            NotificationCenter.default.post(name: NSNotification.Name("Simulate push"), object: self)
        } else {
            view?.showAlertWithTitle(
                "Пример",
                message: "Пример как можно открыть любой модуль из любого места (например, по диплинку)",
                buttonTitle: "Got it",
                onButtonTap: {
                    NotificationCenter.default.post(name: NSNotification.Name("Simulate push"), object: self)
                    UserDefaults.standard.set(true, forKey: key)
                }
            )
        }
    }
    
    // MARK: - Private
    private func showComments(memeId: String) {
        router?.showComments(memeId: memeId) { (module: CommentsModule) in
            module.onFinished = { [weak self] state in
                switch state {
                    case let .removeComment(comment):
                        self?.view?.setDescription("Пользовать удалил комментарий:\n\(comment.title)")
                }
            }
        }
    }
}
