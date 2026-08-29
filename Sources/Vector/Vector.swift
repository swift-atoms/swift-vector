public import Cardinal
public import Cardinal_Carrier
public import Index
public import Ordinal
public import Ordinal_Distance
public import Ordinal_Error
public import Ordinal_Predecessor
public import Ordinal_Protocol
public import Ordinal_Tagged
public import Property_Inout
public import Tagged
internal import Property

public struct Vector<Bound: ~Copyable> {

    public typealias Index = Index::Index<Vector<Bound>>

    public enum ForEach {}

    public enum Drain {}

    public enum Error: Swift.Error, Hashable, Sendable {

        case invalidBounds(start: Index, end: Index)
    }

    public var start: Index

    public var end: Index

    @usableFromInline
    var _count: Index.Count

    @inlinable
    public var count: Index.Count {
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
            guard current < end else { return nil }
            let result = transform(current)

            current += .one
            return result
        }
    }

    public struct Reversed {
        @usableFromInline
        var start: Index

        @usableFromInline
        var end: Index

        @usableFromInline
        var _count: Index.Count

        @inlinable
        public var count: Index.Count {
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

                if start == end {
                    self.current = start
                    self.exhausted = true
                } else {

                    do throws(Ordinal::Ordinal.Error) {
                        self.current = try end.predecessor.exact()
                        self.exhausted = false
                    } catch {
                        self.current = start
                        self.exhausted = true
                    }
                }
            }

            @inlinable
            public mutating func next() -> Bound? {
                guard !exhausted else { return nil }

                let result = transform(current)

                if current == start {
                    exhausted = true
                } else {

                    do throws(Ordinal::Ordinal.Error) {
                        current = try current.predecessor.exact()
                    } catch {
                        exhausted = true
                    }
                }

                return result
            }
        }

        @usableFromInline
        init(
            start: Index,
            end: Index,
            count: Index.Count,
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

            do throws(Ordinal::Ordinal.Error) {
                self._count = Index.Count(try start.position.distance.forward(to: end.position))
            } catch {
                fatalError("invariant violation: \(error)")
            }
            self.transform = transform
        }

        @inlinable
        public var isEmpty: Bool { count == .zero }

        @inlinable
        public consuming func makeIterator() -> Iterator {
            Iterator(start: start, end: end, transform: transform)
        }

        @inlinable
        package mutating func _borrowingForEach<E: Swift.Error>(
            _ body: (borrowing Bound) throws(E) -> Void
        ) throws(E) {
            guard !isEmpty else { return }

            let initial: Index
            do throws(Ordinal::Ordinal.Error) {
                initial = try end.predecessor.exact()
            } catch {
                return
            }
            var i = initial
            while i >= start {
                let bound = transform(i)
                try body(bound)
                if i == start { break }

                do throws(Ordinal::Ordinal.Error) {
                    i = try i.predecessor.exact()
                } catch {
                    break
                }
            }
        }

        @inlinable
        package mutating func _consumingDrain(_ body: (consuming Bound) -> Void) {
            guard !isEmpty else { return }

            let initial: Index
            do throws(Ordinal::Ordinal.Error) {
                initial = try end.predecessor.exact()
            } catch {
                return
            }
            var i = initial
            while i >= start {
                body(transform(i))
                if i == start { break }

                do throws(Ordinal::Ordinal.Error) {
                    i = try i.predecessor.exact()
                } catch {
                    break
                }
            }
            start = end
            count = .zero
        }

        @inlinable
        public var forEach: Property<ForEach, Self> {
            Property(self)
        }

        @inlinable
        public var drain: Property<Drain, Self>.Inout {
            mutating _read {
                yield Property<Drain, Self>.Inout(&self)
            }
            mutating _modify {
                var accessor = Property<Drain, Self>.Inout(&self)
                yield &accessor
            }
        }
    }

    @inlinable
    public init(
        count: Index.Count,
        transform: @escaping @Sendable (Index) -> Bound
    ) {
        self.start = .zero
        self.end = .zero + count
        self._count = count
        self.transform = transform
    }

    @inlinable
    public init(
        start: Index,
        end: Index,
        transform: @escaping @Sendable (Index) -> Bound
    ) throws(Self.Error) {
        guard start <= end else {
            throw .invalidBounds(start: start, end: end)
        }
        self.start = start
        self.end = end

        do throws(Ordinal::Ordinal.Error) {
            self._count = Index.Count(try start.position.distance.forward(to: end.position))
        } catch {
            fatalError("invariant violation: \(error)")
        }
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

        do throws(Ordinal::Ordinal.Error) {
            self._count = Index.Count(try start.position.distance.forward(to: end.position))
        } catch {
            fatalError("invariant violation: \(error)")
        }
        self.transform = transform
    }

    @inlinable
    public var isEmpty: Bool { count == .zero }

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
        while i < end {
            let bound = transform(i)
            try body(bound)

            i += .one
        }
    }

    @inlinable
    package mutating func _consumingDrain(_ body: (consuming Bound) -> Void) {
        var i = start
        while i < end {
            body(transform(i))

            i += .one
        }
        start = end
        count = .zero
    }

    @inlinable
    public var forEach: Property<ForEach, Self> {
        Property(self)
    }

    @inlinable
    public var drain: Property<Drain, Self>.Inout {
        mutating _read {
            yield Property<Drain, Self>.Inout(&self)
        }
        mutating _modify {
            var accessor = Property<Drain, Self>.Inout(&self)
            yield &accessor
        }
    }
}

extension Vector: Sendable where Bound: Sendable {}
extension Vector.Iterator: Sendable where Bound: Sendable {}
extension Vector.Reversed: Sendable where Bound: Sendable {}
extension Vector.Reversed.Iterator: Sendable where Bound: Sendable {}

extension Vector.Iterator: Copyable where Bound: Copyable {}
extension Vector.Reversed.Iterator: Copyable where Bound: Copyable {}
