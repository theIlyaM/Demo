import UIKit

final public class CommentsViewData {
    public let comments: [Comment]
    public let removeButtonTitle: String?
    public let onRemoveTap: Closure.Empty?
    
    public init(
        comments: [Comment],
        removeButtonTitle: String?,
        onRemoveTap: Closure.Empty?)
    {
        self.comments = comments
        self.removeButtonTitle = removeButtonTitle
        self.onRemoveTap = onRemoveTap
    }
}

final public class CommentsView: UIView {
    private let textView = UITextView()
    private let removeButton = UIButton(type: .custom)
    private var onRemoveTap: Closure.Empty?
    
    // MARK: - Init
    public init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setUpView() {
        backgroundColor = .white
        
        addSubview(textView)
        addSubview(removeButton)
        
        removeButton.backgroundColor = .gray
        removeButton.addTarget(self, action: #selector(onRemoveTap(_:)), for: .touchUpInside)
    }
    
    @objc private func onRemoveTap(_ sender: AnyObject) {
        onRemoveTap?()
    }

    // MARK: - Public
    public func setViewData(_ viewData: CommentsViewData) {
        textView.text = viewData.comments.reduce("") { $0 + $1.title + "\n" }
        removeButton.setTitle(viewData.removeButtonTitle, for: .normal)
        
        if let _ = viewData.removeButtonTitle {
            onRemoveTap = viewData.onRemoveTap
        } else {
            onRemoveTap = nil
        }
        
        setNeedsLayout()
    }
    
    // MARK: - Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.frame = CGRect(
            x: bounds.minX,
            y: bounds.minY,
            width: bounds.width,
            height: 200
        )
        
        removeButton.frame = CGRect(
            x: 24,
            y: textView.frame.maxY + 100,
            width: bounds.width - 24*2,
            height: 50
        )
    }
}
