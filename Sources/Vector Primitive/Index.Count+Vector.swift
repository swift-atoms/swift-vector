public import Index_Primitives

@inlinable
public func ..< <Tag: ~Copyable & ~Escapable>(
    lhs: Index<Tag>,
    rhs: Index<Tag>.Count
) -> Vector<Index<Tag>> {
    let start: Vector<Index<Tag>>.Index = lhs.retag()
    let end: Vector<Index<Tag>>.Index = rhs.map(Ordinal.init).retag()

    return Vector(
        __unchecked: (),
        start: start,
        end: end,
        transform: { $0.retag() }
    )
}
