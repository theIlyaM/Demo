import UIKit

final class Application {
    // MARK: - Private properties
    private let window = UIWindow()
    private let serviceFactory: ServiceFactory
    private let moduleFactory: ModuleFactory
    private let pushNotificationHandler: PushNotificationHandler
    
    // MARK: - Init
    init() {
        self.serviceFactory = ServiceFactory()
        self.moduleFactory = ModuleFactoryImpl(
            serviceFactory: serviceFactory
        )
        self.pushNotificationHandler = PushNotificationHandlerImpl(
            deepLinkHandler: DeepLinkHandlerImpl(
                applicationRouterProvider: ApplicationRouterProviderImpl(
                    moduleFactory: moduleFactory,
                    topViewControllerProvider: TopViewControllerProviderImpl()
                )
            )
        )
    }
    
    // MARK: - Public
    func prepare() {
        /*
            Set up Crashlytics, Fabric, etc.
         */
    }
    
    func start() {
        let rootModule = self.moduleFactory.rootAssembly()
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
