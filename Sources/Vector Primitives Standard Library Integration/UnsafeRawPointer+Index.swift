public import Index_Primitives

extension UnsafeRawPointer {

    @inlinable
    public func advanced<Tag: ~Copyable & ~Escapable>(
        by index: Index<Tag>
    ) -> Self {
        unsafe self.advanced(by: Int(bitPattern: index))
    }
}
