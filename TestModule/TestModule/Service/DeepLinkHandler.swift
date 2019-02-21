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
    private let applicationRouterProvider: ApplicationRouterProvider
    
    // MARK: - Init
    public init(applicationRouterProvider: ApplicationRouterProvider) {
        self.applicationRouterProvider = applicationRouterProvider
    }
    
    // MARK: - DeepLinkHandler
    public func handleDeepLink(rawValue: String, completion:Closure.Argument<Bool>?) {
        switch parseDeepLink(rawValue: rawValue) {
        case .feed:
            applicationRouterProvider.rootRouter?.showFeed(presentationStyle: .modal)
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
