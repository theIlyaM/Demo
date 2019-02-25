import Foundation

public protocol DeepLinkHandler: class {
    func handleDeepLink(rawValue: String, completion:Closure.Argument<Bool>?)
}

public enum DeepLink {
    case feed
    case unknown
}

final public class DeepLinkHandlerImpl: DeepLinkHandler {
    // MARK: - Private properties
    private let rootRouter: RootRouter
    
    // MARK: - Init
    public init(rootRouter: RootRouter) {
        self.rootRouter = rootRouter
    }
    
    // MARK: - DeepLinkHandler
    public func handleDeepLink(rawValue: String, completion:Closure.Argument<Bool>?) {
        switch parseDeepLink(rawValue: rawValue) {
        case .feed:
            self.rootRouter.showFeed(presentationStyle: .modal)
        case .unknown:
            break
        }
    }
    
    // MARK: - Private
    public func parseDeepLink(rawValue: String) -> DeepLink {
        // ifunny://feed
        return .feed
    }
}
