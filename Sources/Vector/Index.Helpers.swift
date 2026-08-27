public import Index
internal import Ordinal
@_spi(Internal) public import Tagged

public typealias VectorIndex<Bound: ~Copyable> = Index<Vector<Bound>>

@usableFromInline
internal func _rawValue<Tag: ~Copyable & ~Escapable>(_ index: Index<Tag>) -> UInt {
    index.underlying.rawValue
}

@usableFromInline
internal func _index<Tag: ~Copyable & ~Escapable>(
    _ rawValue: UInt,
    as _: Tag.Type = Tag.self
) -> Index<Tag> {
    Index(_unchecked: Ordinal(rawValue))
}

@usableFromInline
internal func _successor<Tag: ~Copyable & ~Escapable>(_ index: Index<Tag>) -> Index<Tag> {
    _index(_rawValue(index) + 1)
}

@usableFromInline
internal func _predecessor<Tag: ~Copyable & ~Escapable>(_ index: Index<Tag>) -> Index<Tag> {
    _index(_rawValue(index) - 1)
}
