import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Private properties
    private let app = Application()
    
    // MARK: - Internal
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool
    {
        emulatePush() // As example to simulate sending push notifications from server
        
        app.prepare()
        app.start()
        
        return true
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        app.handleRemoteNotification(userInfo: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    // MARK: - Private
    private func emulatePush() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("Simulate push"),
            object: nil,
            queue: nil,
            using: { [weak self] _ in
                self?.app.handleRemoteNotification(
                    userInfo: [:],
                    fetchCompletionHandler: { _ in
                    
                    }
                )
            }
        )
    }
}

