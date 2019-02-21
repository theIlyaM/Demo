import UIKit

public protocol FeedViewInput: class, AlertDisplayable {
    func setTitle(_: String)
    func setDescription(_: String?)
    func setButtonViewData(_: FeedButtonViewData)    
}

public protocol FeedViewOutput: class {
    func onViewDidLoad()
    func onViewWillAppear()
    func onRightBarButtonItemTap()
    func onLeftBarButtonItemTap()
}

final public class FeedViewControllerSettings {
    public enum NavigationItemStyle {
        case none
        case closeLeftButton
    }
    
    // MARK: - Public properties
    public let navigationItemStyle: NavigationItemStyle
    
    // MARK: - Init
    public init(navigationItemStyle: NavigationItemStyle) {
        self.navigationItemStyle = navigationItemStyle
    }
}

final public class FeedViewController: UIViewController, FeedViewInput {

    
    // MARK: - Private properties
    private let feedView = FeedView()
    
    // MARK: - Public properties
    public let viewOutput: FeedViewOutput
    public let settings: FeedViewControllerSettings
    
    // MARK: - Init
    public init(viewOutput: FeedViewOutput, settings: FeedViewControllerSettings) {
        self.viewOutput = viewOutput
        self.settings = settings
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    public override func loadView() {
        view = feedView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        
        viewOutput.onViewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewOutput.onViewWillAppear()
    }
    
    // MARK: - FeedViewInput
    public func setTitle(_ title: String) {
        feedView.setTitle(title)
    }
    
    public func setButtonViewData(_ buttonViewData: FeedButtonViewData) {
        feedView.setButtonViewData(buttonViewData)
    }
    
    public func setDescription(_ description: String?) {
        feedView.setDescription(description)
    }
    
    // MARK: - Private
    private func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Send push",
            style: .done,
            target: self,
            action: #selector(onRightBarButtonItemTap(_:))
        )
        
        switch settings.navigationItemStyle {
        case .none:
            navigationItem.leftBarButtonItem = nil
        case .closeLeftButton:
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "X",
                style: .done,
                target: self,
                action: #selector(onLeftBarButtonItemTap(_:))
            )
        }
    }
    
    @objc private func onLeftBarButtonItemTap(_ sender: Any) {
        viewOutput.onLeftBarButtonItemTap()
    }
    
    @objc private func onRightBarButtonItemTap(_ sender: Any) {
        viewOutput.onRightBarButtonItemTap()
    }
}
