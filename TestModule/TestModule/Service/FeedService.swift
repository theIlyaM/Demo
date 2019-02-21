import Foundation

public protocol FeedService: class {
    func loadFeed(completion: Closure.Argument<Meme>?)
}

final public class FeedServiceImpl: FeedService {
    // MARK: - FeedService
    public func loadFeed(completion: Closure.Argument<Meme>?) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.async {
                completion?(Meme(id: "123"))
            }
        }
    }
}
