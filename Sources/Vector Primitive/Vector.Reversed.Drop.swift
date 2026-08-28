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
    public consuming func first(_ count: Vector<Bound>.Index.Count) -> Vector<Bound>.Reversed {
        let newEnd = base.end.retreat.clamped(by: count, to: base.start)
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

        let initial: Vector<Bound>.Index
        do throws(Ordinal.Error) {
            initial = try base.end.predecessor.exact()
        } catch {
            return result
        }
        var i = initial
        while i >= base.start {
            let element = base.transform(i)
            if dropping && predicate(element) {
                if i == base.start { break }

                do throws(Ordinal.Error) {
                    i = try i.predecessor.exact()
                } catch {
                    break
                }
                continue
            }
            dropping = false
            result.append(element)
            if i == base.start { break }

            do throws(Ordinal.Error) {
                i = try i.predecessor.exact()
            } catch {
                break
            }
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
