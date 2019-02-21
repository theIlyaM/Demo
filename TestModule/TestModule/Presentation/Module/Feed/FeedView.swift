import UIKit

public enum FeedButtonViewData {
    case loading
    case data(title: String, onTap: Closure.Empty?)
}

final public class FeedView: UIView {
    // MARK: - Private properties
    private let titleLable = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton(type: .custom)
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private var onActionTap: Closure.Empty?
    
    // MARK: - Init
    public init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    public func setButtonViewData(_ buttonViewData: FeedButtonViewData) {
        switch buttonViewData {
        case .loading:
            actionButton.setTitle(nil, for: .normal)
            onActionTap = nil
            actionButton.isEnabled = false
            activityIndicator.startAnimating()
        case let .data(title, onTap):
            actionButton.setTitle(title, for: .normal)
            onActionTap = onTap
            actionButton.isEnabled = true
            activityIndicator.stopAnimating()
        }
        
        setNeedsLayout()
    }
    
    func setTitle(_ title: String) {
        titleLable.text = title
        
        setNeedsLayout()
    }
    
    func setDescription(_ description: String?) {
        descriptionLabel.text = description
        
        setNeedsLayout()
    }
    
    // MARK: - Private
    private func setUpView() {
        backgroundColor = .white
        
        addSubview(titleLable)
        titleLable.textAlignment = .center
        
        addSubview(actionButton)        
        actionButton.backgroundColor = .gray
        actionButton.addTarget(self, action: #selector(onActionTap(_:)), for: .touchUpInside)
        
        actionButton.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        
        addSubview(descriptionLabel)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
    }
    
    @objc private func onActionTap(_ sender: AnyObject) {
        onActionTap?()
    }
    
    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLable.frame = CGRect(
            x: 24,
            y: 200 + 50,
            width: bounds.width - 24*2,
            height: 50
        )
        actionButton.frame = CGRect(
            x: titleLable.frame.minX,
            y: titleLable.frame.maxY + 50,
            width: titleLable.frame.width,
            height: 50
        )
        activityIndicator.frame = actionButton.bounds
        descriptionLabel.frame = CGRect(
            x: titleLable.frame.minX,
            y: actionButton.frame.maxY + 50,
            width: titleLable.frame.width,
            height: 50
        )
    }
}
