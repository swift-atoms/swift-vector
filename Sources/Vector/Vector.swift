public import Property

public struct Vector<Bound: ~Copyable> {

    public typealias Index = VectorIndex<Bound>
    public typealias Count = UInt

    public enum ForEach {}

    public enum Drain {}

    public enum Error: Swift.Error, Sendable {

        case invalidBounds(start: Index, end: Index)
    }

    public var start: Index

    public var end: Index

    @usableFromInline
    var _count: Count

    @inlinable
    public var count: Count {
        _read { yield _count }
        _modify { yield &_count }
    }

    @usableFromInline
    let transform: @Sendable (Index) -> Bound

    public struct Iterator: ~Copyable {
        @usableFromInline
        var current: Index

        @usableFromInline
        let end: Index

        @usableFromInline
        let transform: @Sendable (Index) -> Bound

        @inlinable
        package init(current: Index, end: Index, transform: @escaping @Sendable (Index) -> Bound) {
            self.current = current
            self.end = end
            self.transform = transform
        }

        @inlinable
        public mutating func next() -> Bound? {
            guard _rawValue(current) < _rawValue(end) else { return nil }
            let result = transform(current)

            current = _successor(current)
            return result
        }
    }

    public struct Reversed {
        @usableFromInline
        var start: Index

        @usableFromInline
        var end: Index

        @usableFromInline
        var _count: Count

        @inlinable
        public var count: Count {
            _read { yield _count }
            _modify { yield &_count }
        }

        @usableFromInline
        let transform: @Sendable (Index) -> Bound

        public struct Iterator: ~Copyable {
            @usableFromInline
            var current: Index

            @usableFromInline
            let start: Index

            @usableFromInline
            let transform: @Sendable (Index) -> Bound

            @usableFromInline
            var exhausted: Bool

            @inlinable
            package init(start: Index, end: Index, transform: @escaping @Sendable (Index) -> Bound)
            {
                self.start = start
                self.transform = transform

                if _rawValue(start) == _rawValue(end) {
                    self.current = start
                    self.exhausted = true
                } else {

                    self.current = _predecessor(end)
                    self.exhausted = false
                }
            }

            @inlinable
            public mutating func next() -> Bound? {
                guard !exhausted else { return nil }

                let result = transform(current)

                if _rawValue(current) == _rawValue(start) {
                    exhausted = true
                } else {
                    current = _predecessor(current)
                }

                return result
            }
        }

        @usableFromInline
        init(
            start: Index,
            end: Index,
            count: Count,
            transform: @escaping @Sendable (Index) -> Bound
        ) {
            self.start = start
            self.end = end
            self._count = count
            self.transform = transform
        }

        @usableFromInline
        init(
            __unchecked: Void,
            start: Index,
            end: Index,
            transform: @escaping @Sendable (Index) -> Bound
        ) {
            self.start = start
            self.end = end

            self._count = _rawValue(end) - _rawValue(start)
            self.transform = transform
        }

        @inlinable
        public var isEmpty: Bool { count == 0 }

        @inlinable
        public consuming func makeIterator() -> Iterator {
            Iterator(start: start, end: end, transform: transform)
        }

        @inlinable
        package mutating func _borrowingForEach<E: Swift.Error>(
            _ body: (borrowing Bound) throws(E) -> Void
        ) throws(E) {
            guard !isEmpty else { return }

            let initial = _predecessor(end)
            var i = initial
            while _rawValue(i) >= _rawValue(start) {
                let bound = transform(i)
                try body(bound)
                if _rawValue(i) == _rawValue(start) { break }
                i = _predecessor(i)
            }
        }

        @inlinable
        package mutating func _consumingDrain(_ body: (consuming Bound) -> Void) {
            guard !isEmpty else { return }

            let initial = _predecessor(end)
            var i = initial
            while _rawValue(i) >= _rawValue(start) {
                body(transform(i))
                if _rawValue(i) == _rawValue(start) { break }
                i = _predecessor(i)
            }
            start = end
            count = 0
        }

        @inlinable
        public var forEach: Property<ForEach, Self> {
            Property(self)
        }

        @inlinable
        public mutating func drain(_ body: (consuming Bound) -> Void) {
            _consumingDrain(body)
        }
    }

    @inlinable
    public init(
        count: Count,
        transform: @escaping @Sendable (Index) -> Bound
    ) {
        self.start = _index(0)
        self.end = _index(count)
        self._count = count
        self.transform = transform
    }

    @inlinable
    public init(
        start: Index,
        end: Index,
        transform: @escaping @Sendable (Index) -> Bound
    ) throws(Self.Error) {
        guard _rawValue(start) <= _rawValue(end) else {
            throw .invalidBounds(start: start, end: end)
        }
        self.start = start
        self.end = end

        self._count = _rawValue(end) - _rawValue(start)
        self.transform = transform
    }

    @usableFromInline
    package init(
        __unchecked: Void,
        start: Index,
        end: Index,
        transform: @escaping @Sendable (Index) -> Bound
    ) {
        self.start = start
        self.end = end

        self._count = _rawValue(end) - _rawValue(start)
        self.transform = transform
    }

    @inlinable
    public var isEmpty: Bool { count == 0 }

    @inlinable
    public subscript(offset: Count) -> Bound {
        precondition(offset < count, "Offset out of bounds")
        return transform(_index(_rawValue(start) + offset))
    }

    @inlinable
    public consuming func makeIterator() -> Iterator {
        Iterator(current: start, end: end, transform: transform)
    }

    @inlinable
    public consuming func reversed() -> Reversed {
        Reversed(start: start, end: end, count: count, transform: transform)
    }

    @inlinable
    package mutating func _borrowingForEach<E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) {
        var i = start
        while _rawValue(i) < _rawValue(end) {
            let bound = transform(i)
            try body(bound)

            i = _successor(i)
        }
    }

    @inlinable
    package mutating func _consumingDrain(_ body: (consuming Bound) -> Void) {
        var i = start
        while _rawValue(i) < _rawValue(end) {
            body(transform(i))

            i = _successor(i)
        }
        start = end
        count = 0
    }

    @inlinable
    public var forEach: Property<ForEach, Self> {
        Property(self)
    }

    @inlinable
    public mutating func drain(_ body: (consuming Bound) -> Void) {
        _consumingDrain(body)
    }
}

extension Vector: Sendable where Bound: Sendable {}
extension Vector.Iterator: Sendable where Bound: Sendable {}
extension Vector.Reversed: Sendable where Bound: Sendable {}
extension Vector.Reversed.Iterator: Sendable where Bound: Sendable {}

extension Vector.Iterator: Copyable where Bound: Copyable {}
extension Vector.Reversed.Iterator: Copyable where Bound: Copyable {}
