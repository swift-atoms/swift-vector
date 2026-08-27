extension Vector {

    public struct Prefix: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>

        @inlinable
        package init(_ base: Vector<Bound>) {
            self.base = base
        }
    }
}

extension Vector.Prefix where Bound: Copyable {

    @inlinable
    public consuming func first(
        _ count: Vector<Bound>.Count
    ) -> Vector<Bound> {
        let kept = Swift.min(count, base.count)
        let newEnd: Vector<Bound>.Index = _index(_rawValue(base.start) + kept)

        return Vector<Bound>(
            __unchecked: (),
            start: base.start,
            end: newEnd,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var i = _rawValue(base.start)
        let end = _rawValue(base.end)
        while i < end {
            let element = base.transform(_index(i))
            if !predicate(element) { break }
            result.append(element)

            i += 1
        }
        return result
    }
}

extension Vector where Bound: Copyable {

    @inlinable
    public var `prefix`: Prefix {
        Prefix(self)
    }
}
