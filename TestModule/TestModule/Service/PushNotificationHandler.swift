import Foundation

public protocol PushNotificationHandler: class {
    func handleRemoteNotification(userInfo: [AnyHashable : Any], completion:Closure.Argument<Bool>?)
}

public enum PushNotification {
    case deepLink(rawValue: String)
    case prefetchingMetadata(rawValue: String)
    case unknown
}

final public class PushNotificationHandlerImpl: PushNotificationHandler {
    // MARK: - Private properties
    private let deepLinkHandler: DeepLinkHandler
    
    // MARK: - Init
    public init(deepLinkHandler: DeepLinkHandler) {
        self.deepLinkHandler = deepLinkHandler
    }
    
    // MARK: - PushNotificationHandler
    public func handleRemoteNotification(userInfo: [AnyHashable : Any], completion:Closure.Argument<Bool>?) {
        switch parsePushNotification(userInfo: userInfo) {
        case let .deepLink(rawValue):
            deepLinkHandler.handleDeepLink(rawValue: rawValue, completion: completion)
        case .prefetchingMetadata:
            break
        case .unknown:
            completion?(false)
        }
    }
    
    // MARK: - Private
    private func parsePushNotification(userInfo: [AnyHashable : Any]) -> PushNotification {
        return .deepLink(rawValue: "ifunny://feed")
    }
}
