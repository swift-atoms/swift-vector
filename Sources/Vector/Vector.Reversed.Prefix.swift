extension Vector.Reversed {

    public struct Prefix: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>.Reversed

        @inlinable
        package init(_ base: Vector<Bound>.Reversed) {
            self.base = base
        }
    }
}

extension Vector.Reversed.Prefix where Bound: Copyable {

    @inlinable
    public consuming func first(_ count: Vector<Bound>.Count) -> Vector<Bound>.Reversed {
        let kept = Swift.min(count, base.count)
        let newStart: Vector<Bound>.Index = _index(_rawValue(base.end) - kept)
        return Vector<Bound>.Reversed(
            __unchecked: (),
            start: newStart,
            end: base.end,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        guard !base.isEmpty else { return result }

        var i = _rawValue(base.end) - 1
        let start = _rawValue(base.start)
        while i >= start {
            let element = base.transform(_index(i))
            if !predicate(element) { break }
            result.append(element)
            if i == start { break }
            i -= 1
        }
        return result
    }
}

extension Vector.Reversed where Bound: Copyable {

    @inlinable
    public var `prefix`: Prefix {
        Prefix(self)
    }
}
