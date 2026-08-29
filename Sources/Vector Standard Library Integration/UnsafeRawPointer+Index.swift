public import Index
public import Ordinal_Standard_Library_Integration

extension UnsafeRawPointer {

    @inlinable
    public func advanced<Tag: ~Copyable & ~Escapable>(
        by index: Index::Index<Tag>
    ) -> Self {
        unsafe self.advanced(by: Int(bitPattern: index))
    }
}
