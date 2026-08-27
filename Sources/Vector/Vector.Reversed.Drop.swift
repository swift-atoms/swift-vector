extension Vector.Reversed {

    public struct Drop: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>.Reversed

        @inlinable
        package init(_ base: Vector<Bound>.Reversed) {
            self.base = base
        }
    }
}

extension Vector.Reversed.Drop where Bound: Copyable {

    @inlinable
    public consuming func first(_ count: Vector<Bound>.Count) -> Vector<Bound>.Reversed {
        let dropped = Swift.min(count, base.count)
        let newEnd: Vector<Bound>.Index = _index(_rawValue(base.end) - dropped)
        return Vector<Bound>.Reversed(
            __unchecked: (),
            start: base.start,
            end: newEnd,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var dropping = true
        guard !base.isEmpty else { return result }

        var i = _rawValue(base.end) - 1
        let start = _rawValue(base.start)
        while i >= start {
            let element = base.transform(_index(i))
            if dropping && predicate(element) {
                if i == start { break }
                i -= 1
                continue
            }
            dropping = false
            result.append(element)
            if i == start { break }
            i -= 1
        }
        return result
    }
}

extension Vector.Reversed where Bound: Copyable {

    @inlinable
    public var drop: Drop {
        Drop(self)
    }
}
