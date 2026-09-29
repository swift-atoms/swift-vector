#if Iterator
public import Iterator

extension Vector {
    public struct Iterator: Iterator::Iterator.`Protocol` {
        public typealias Element = Scalar
        public typealias Failure = Never
        private let vector: Vector<N, Scalar>
        private let reverse: Bool
        private var position: Int = 0

        fileprivate init(_ vector: Vector<N, Scalar>, reverse: Bool) {
            self.vector = vector
            self.reverse = reverse
        }

        public mutating func next() -> Scalar? {
            guard position < N else { return nil }
            let index = reverse ? N - 1 - position : position
            position += 1
            return vector[index]
        }
    }

    public consuming func makeIterator() -> Iterator { Iterator(self, reverse: false) }

    public struct Reversed {
        public typealias Iterator = Vector<N, Scalar>.Iterator
        fileprivate let vector: Vector<N, Scalar>
        public consuming func makeIterator() -> Iterator { Iterator(vector, reverse: true) }
    }

    public borrowing func reversed() -> Reversed { Reversed(vector: copy self) }
}
#endif
