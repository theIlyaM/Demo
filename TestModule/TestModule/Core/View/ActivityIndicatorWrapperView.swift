import UIKit

final public class ActivityIndicatorWrapperView<ViewType>: UIView, ActivityDisplayable where ViewType: UIView {
    // MARK: - Private properties
    private let view: ViewType
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Public properties
    public var contentView: ViewType {
        return view
    }
    
    // MARK: - Init
    public init(view: ViewType) {
        self.view = view
        
        super.init(frame: .zero)
        
        addSubview(view)
        addSubview(activityIndicator)
        
        activityIndicator.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        view.frame = bounds
        activityIndicator.frame = bounds
    }
    
    // MARK: - ActivityDisplayable
    public func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    public func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
