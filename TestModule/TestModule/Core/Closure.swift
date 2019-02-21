import Foundation

public struct Closure {
    public typealias Empty = () -> ()
    public typealias Argument<T> = (_: T) -> ()
    public typealias Map<T, U> = (_: T) -> U
}
