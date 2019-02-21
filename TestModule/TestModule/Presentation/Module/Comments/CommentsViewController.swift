import UIKit

public protocol CommentsViewInput: class, AlertDisplayable, ActivityDisplayable {
    func setViewData(_ viewData: CommentsViewData)
}

public protocol CommentsViewOutput: class {
    func onViewDidLoad()
    func onViewWillAppear()
}

final public class CommentsViewController: UIViewController, CommentsViewInput {
    // MARK: - Private properties
    private let сommentsView = CommentsView()
    private let activityIndicatorView: ActivityIndicatorWrapperView<CommentsView>
    
    // MARK: - Public properties
    public let viewOutput: CommentsViewOutput

    // MARK: - Init
    public init(viewOutput: CommentsViewOutput) {
        self.viewOutput = viewOutput
        self.activityIndicatorView = ActivityIndicatorWrapperView(view: сommentsView)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    public override func loadView() {
        view = activityIndicatorView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOutput.onViewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewOutput.onViewWillAppear()
    }
    
    // MARK: - CommentsViewInput
    public func setViewData(_ viewData: CommentsViewData) {
        сommentsView.setViewData(viewData)
    }
    
    // MARK: - ActivityDisplayable
    public func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    public func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
