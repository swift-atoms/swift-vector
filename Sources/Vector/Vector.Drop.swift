extension Vector {

    public struct Drop: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>

        @inlinable
        package init(_ base: Vector<Bound>) {
            self.base = base
        }
    }
}

extension Vector.Drop where Bound: Copyable {

    @inlinable
    public consuming func first(
        _ count: Vector<Bound>.Count
    ) -> Vector<Bound> {
        let dropped = Swift.min(count, base.count)
        let newStart: Vector<Bound>.Index = _index(_rawValue(base.start) + dropped)
        return Vector<Bound>(
            __unchecked: (),
            start: newStart,
            end: base.end,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var dropping = true
        var i = _rawValue(base.start)
        let end = _rawValue(base.end)
        while i < end {
            let element = base.transform(_index(i))

            let next = i + 1
            if dropping && predicate(element) {
                i = next
                continue
            }
            dropping = false
            result.append(element)
            i = next
        }
        return result
    }
}

extension Vector where Bound: Copyable {

    @inlinable
    public var drop: Drop {
        Drop(self)
    }
}
