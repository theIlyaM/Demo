import UIKit
import Dip

final class Application {
    // MARK: - Private properties
    private let window = UIWindow()
    lazy private var pushNotificationHandler: PushNotificationHandler = {
        return try! container.resolve()
    }()
    let container: DependencyContainer
    
    // MARK: - Init
    init() {
        self.container = DIContainer.container()
        try! self.container.bootstrap()
    }
    
    // MARK: - Public
    func prepare() {
        /*
            Set up Crashlytics, Fabric, etc.
         */
    }
    
    func start() {
        let rootModule = try! container.resolve() as RootAssembly
        window.rootViewController = rootModule.create().view
        window.makeKeyAndVisible()
    }
    
    func handleRemoteNotification(
        userInfo: [AnyHashable : Any],
        fetchCompletionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        pushNotificationHandler.handleRemoteNotification(userInfo: userInfo) { success in
            let result: UIBackgroundFetchResult = success ? .newData : .failed
            fetchCompletionHandler(result)
        }
    }
}
