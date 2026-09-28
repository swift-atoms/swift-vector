#if Sequence
import Sequence
import Testing
import Vector
import Vector_Test_Support

@Suite("Vector × Sequence terminal operations")
struct Vector_Sequence_Operations_Tests {

    @Test
    func `satisfies all reports whether every element matches`()  {
        var allMatch = Vector<10, Int>(InlineArray { $0 + 0 })
        var oneDoesNotMatch = Vector<10, Int>(InlineArray { $0 + 0 })

        #expect(allMatch.satisfies.all { $0 >= 0 })
        #expect(!oneDoesNotMatch.satisfies.all { $0 > 5 })
    }

    @Test
    func `satisfies any reports whether an element matches`()  {
        var oneMatches = Vector<10, Int>(InlineArray { $0 + 0 })
        var noneMatch = Vector<10, Int>(InlineArray { $0 + 0 })

        #expect(oneMatches.satisfies.any { $0 == 5 })
        #expect(!noneMatch.satisfies.any { $0 > 100 })
    }

    @Test
    func `satisfies none reports whether no element matches`()  {
        var noneMatch = Vector<10, Int>(InlineArray { $0 + 0 })
        var oneMatches = Vector<10, Int>(InlineArray { $0 + 0 })

        #expect(noneMatch.satisfies.none { $0 < 0 })
        #expect(!oneMatches.satisfies.none { $0 == 5 })
    }

    @Test
    func `empty Vector has the expected predicate identities`()  {
        var forAll = Vector<0, Int>(InlineArray { $0 + 0 })
        var forAny = Vector<0, Int>(InlineArray { $0 + 0 })

        #expect(forAll.satisfies.all { _ in false })
        #expect(!forAny.satisfies.any { _ in true })
    }

    @Test
    func `reversed Vector supports predicate operations`()  {
        let vector = Vector<10, Int>(InlineArray { $0 + 0 })
        var reversed = vector.reversed()

        #expect(reversed.satisfies.all { $0 >= 0 && $0 < 10 })
    }

    @Test
    func `satisfies any is the inverse of satisfies none`()  {
        do {

            var anyEvenVector = Vector<0, Int>(InlineArray { $0 + 0 })
            var noneEvenVector = Vector<0, Int>(InlineArray { $0 + 0 })
            var anyNegativeVector = Vector<0, Int>(InlineArray { $0 + 0 })
            var noneNegativeVector = Vector<0, Int>(InlineArray { $0 + 0 })

            let anyEven = anyEvenVector.satisfies.any { $0.isMultiple(of: 2) }
            let noneEven = noneEvenVector.satisfies.none { $0.isMultiple(of: 2) }
            let anyNegative = anyNegativeVector.satisfies.any { $0 < 0 }
            let noneNegative = noneNegativeVector.satisfies.none { $0 < 0 }

            #expect(anyEven == !noneEven)
            #expect(anyNegative == !noneNegative)

}
do {

            var anyEvenVector = Vector<1, Int>(InlineArray { $0 + 0 })
            var noneEvenVector = Vector<1, Int>(InlineArray { $0 + 0 })
            var anyNegativeVector = Vector<1, Int>(InlineArray { $0 + 0 })
            var noneNegativeVector = Vector<1, Int>(InlineArray { $0 + 0 })

            let anyEven = anyEvenVector.satisfies.any { $0.isMultiple(of: 2) }
            let noneEven = noneEvenVector.satisfies.none { $0.isMultiple(of: 2) }
            let anyNegative = anyNegativeVector.satisfies.any { $0 < 0 }
            let noneNegative = noneNegativeVector.satisfies.none { $0 < 0 }

            #expect(anyEven == !noneEven)
            #expect(anyNegative == !noneNegative)

}
do {

            var anyEvenVector = Vector<5, Int>(InlineArray { $0 + 0 })
            var noneEvenVector = Vector<5, Int>(InlineArray { $0 + 0 })
            var anyNegativeVector = Vector<5, Int>(InlineArray { $0 + 0 })
            var noneNegativeVector = Vector<5, Int>(InlineArray { $0 + 0 })

            let anyEven = anyEvenVector.satisfies.any { $0.isMultiple(of: 2) }
            let noneEven = noneEvenVector.satisfies.none { $0.isMultiple(of: 2) }
            let anyNegative = anyNegativeVector.satisfies.any { $0 < 0 }
            let noneNegative = noneNegativeVector.satisfies.none { $0 < 0 }

            #expect(anyEven == !noneEven)
            #expect(anyNegative == !noneNegative)

}
do {

            var anyEvenVector = Vector<20, Int>(InlineArray { $0 + 0 })
            var noneEvenVector = Vector<20, Int>(InlineArray { $0 + 0 })
            var anyNegativeVector = Vector<20, Int>(InlineArray { $0 + 0 })
            var noneNegativeVector = Vector<20, Int>(InlineArray { $0 + 0 })

            let anyEven = anyEvenVector.satisfies.any { $0.isMultiple(of: 2) }
            let noneEven = noneEvenVector.satisfies.none { $0.isMultiple(of: 2) }
            let anyNegative = anyNegativeVector.satisfies.any { $0 < 0 }
            let noneNegative = noneNegativeVector.satisfies.none { $0 < 0 }

            #expect(anyEven == !noneEven)
            #expect(anyNegative == !noneNegative)

}
    }

    @Test
    func `satisfies all implies satisfies any for a nonempty Vector`()  {
        do {

            var allVector = Vector<1, Int>(InlineArray { $0 + 0 })
            var anyVector = Vector<1, Int>(InlineArray { $0 + 0 })

            let allNonnegative = allVector.satisfies.all { $0 >= 0 }
            let anyNonnegative = anyVector.satisfies.any { $0 >= 0 }

            if allNonnegative {
                #expect(anyNonnegative)
            }

}
do {

            var allVector = Vector<5, Int>(InlineArray { $0 + 0 })
            var anyVector = Vector<5, Int>(InlineArray { $0 + 0 })

            let allNonnegative = allVector.satisfies.all { $0 >= 0 }
            let anyNonnegative = anyVector.satisfies.any { $0 >= 0 }

            if allNonnegative {
                #expect(anyNonnegative)
            }

}
do {

            var allVector = Vector<20, Int>(InlineArray { $0 + 0 })
            var anyVector = Vector<20, Int>(InlineArray { $0 + 0 })

            let allNonnegative = allVector.satisfies.all { $0 >= 0 }
            let anyNonnegative = anyVector.satisfies.any { $0 >= 0 }

            if allNonnegative {
                #expect(anyNonnegative)
            }

}
    }

    @Test
    func `satisfies all agrees for forward and reversed traversal`()  {
        do {

            var forward = Vector<0, Int>(InlineArray { $0 + 0 })
            let vector = Vector<0, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            #expect(
                forward.satisfies.all { $0 >= 0 }
                    == reversed.satisfies.all { $0 >= 0 }
            )

}
do {

            var forward = Vector<1, Int>(InlineArray { $0 + 0 })
            let vector = Vector<1, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            #expect(
                forward.satisfies.all { $0 >= 0 }
                    == reversed.satisfies.all { $0 >= 0 }
            )

}
do {

            var forward = Vector<5, Int>(InlineArray { $0 + 0 })
            let vector = Vector<5, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            #expect(
                forward.satisfies.all { $0 >= 0 }
                    == reversed.satisfies.all { $0 >= 0 }
            )

}
do {

            var forward = Vector<20, Int>(InlineArray { $0 + 0 })
            let vector = Vector<20, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            #expect(
                forward.satisfies.all { $0 >= 0 }
                    == reversed.satisfies.all { $0 >= 0 }
            )

}
    }

    @Test
    func `predicate operations remain correct across representative sizes`()  {
        do {

            var anyVector = Vector<0, Int>(InlineArray { $0 + 0 })
            var allVector = Vector<0, Int>(InlineArray { $0 + 0 })

            let anyEven = anyVector.satisfies.any { $0.isMultiple(of: 2) }
            let allEven = allVector.satisfies.all { $0.isMultiple(of: 2) }

            if 0 <= 1 {
                #expect(anyEven == (0 == 1))
                #expect(allEven)
            } else {
                #expect(anyEven)
                #expect(!allEven)
            }

}
do {

            var anyVector = Vector<1, Int>(InlineArray { $0 + 0 })
            var allVector = Vector<1, Int>(InlineArray { $0 + 0 })

            let anyEven = anyVector.satisfies.any { $0.isMultiple(of: 2) }
            let allEven = allVector.satisfies.all { $0.isMultiple(of: 2) }

            if 1 <= 1 {
                #expect(anyEven == (1 == 1))
                #expect(allEven)
            } else {
                #expect(anyEven)
                #expect(!allEven)
            }

}
do {

            var anyVector = Vector<2, Int>(InlineArray { $0 + 0 })
            var allVector = Vector<2, Int>(InlineArray { $0 + 0 })

            let anyEven = anyVector.satisfies.any { $0.isMultiple(of: 2) }
            let allEven = allVector.satisfies.all { $0.isMultiple(of: 2) }

            if 2 <= 1 {
                #expect(anyEven == (2 == 1))
                #expect(allEven)
            } else {
                #expect(anyEven)
                #expect(!allEven)
            }

}
do {

            var anyVector = Vector<10, Int>(InlineArray { $0 + 0 })
            var allVector = Vector<10, Int>(InlineArray { $0 + 0 })

            let anyEven = anyVector.satisfies.any { $0.isMultiple(of: 2) }
            let allEven = allVector.satisfies.all { $0.isMultiple(of: 2) }

            if 10 <= 1 {
                #expect(anyEven == (10 == 1))
                #expect(allEven)
            } else {
                #expect(anyEven)
                #expect(!allEven)
            }

}
do {

            var anyVector = Vector<100, Int>(InlineArray { $0 + 0 })
            var allVector = Vector<100, Int>(InlineArray { $0 + 0 })

            let anyEven = anyVector.satisfies.any { $0.isMultiple(of: 2) }
            let allEven = allVector.satisfies.all { $0.isMultiple(of: 2) }

            if 100 <= 1 {
                #expect(anyEven == (100 == 1))
                #expect(allEven)
            } else {
                #expect(anyEven)
                #expect(!allEven)
            }

}
do {

            var anyVector = Vector<500, Int>(InlineArray { $0 + 0 })
            var allVector = Vector<500, Int>(InlineArray { $0 + 0 })

            let anyEven = anyVector.satisfies.any { $0.isMultiple(of: 2) }
            let allEven = allVector.satisfies.all { $0.isMultiple(of: 2) }

            if 500 <= 1 {
                #expect(anyEven == (500 == 1))
                #expect(allEven)
            } else {
                #expect(anyEven)
                #expect(!allEven)
            }

}
    }

    @Test
    func `reduce into accumulates in forward order`()  {
        var vector = Vector<5, Int>(InlineArray { $0 + 1 })
        var order: [Int] = []

        let sum = vector.reduce.into(0) { accumulator, value in
            order.append(value)
            accumulator += value
        }

        #expect(sum == 15)
        #expect(order == [1, 2, 3, 4, 5])
    }

    @Test
    func `reduce from combines elements`()  {
        var vector = Vector<4, Int>(InlineArray { $0 + 1 })
        let product = vector.reduce.from(1) { $0 * $1 }

        #expect(product == 24)
    }

    @Test
    func `reduce into follows reversed traversal order`()  {
        let vector = Vector<3, Int>(InlineArray { $0 + 1 })
        var reversed = vector.reversed()
        var order: [Int] = []

        _ = reversed.reduce.into(0) { accumulator, value in
            order.append(value)
            accumulator += value
        }

        #expect(order == [3, 2, 1])
    }

    @Test
    func `empty Vector reductions return their initial values`()  {
        var intoVector = Vector<0, Int>(InlineArray { $0 + 0 })
        var fromVector = Vector<0, Int>(InlineArray { $0 + 0 })

        let intoResult = intoVector.reduce.into(42) { accumulator, _ in
            accumulator += 1
        }
        let fromResult = fromVector.reduce.from(42) { _, _ in 0 }

        #expect(intoResult == 42)
        #expect(fromResult == 42)
    }

    @Test
    func `forward and reversed reductions produce the same sum`()  {
        do {

            var forward = Vector<0, Int>(InlineArray { $0 + 0 })
            let vector = Vector<0, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            let forwardSum = forward.reduce.into(0) { $0 += $1 }
            let reversedSum = reversed.reduce.into(0) { $0 += $1 }

            #expect(forwardSum == reversedSum)

}
do {

            var forward = Vector<1, Int>(InlineArray { $0 + 0 })
            let vector = Vector<1, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            let forwardSum = forward.reduce.into(0) { $0 += $1 }
            let reversedSum = reversed.reduce.into(0) { $0 += $1 }

            #expect(forwardSum == reversedSum)

}
do {

            var forward = Vector<5, Int>(InlineArray { $0 + 0 })
            let vector = Vector<5, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            let forwardSum = forward.reduce.into(0) { $0 += $1 }
            let reversedSum = reversed.reduce.into(0) { $0 += $1 }

            #expect(forwardSum == reversedSum)

}
do {

            var forward = Vector<20, Int>(InlineArray { $0 + 0 })
            let vector = Vector<20, Int>(InlineArray { $0 + 0 })
            var reversed = vector.reversed()

            let forwardSum = forward.reduce.into(0) { $0 += $1 }
            let reversedSum = reversed.reduce.into(0) { $0 += $1 }

            #expect(forwardSum == reversedSum)

}
    }

    @Test
    func `alternating forward and reversed reductions remain stable`()  {
        do {

            var forwardSum = 0
            var reversedSum = 0

            for iteration in 0..<10 {
                if iteration.isMultiple(of: 2) {
                    var vector = Vector<1, Int>(InlineArray { $0 + 0 })
                    forwardSum += vector.reduce.into(0) { $0 += $1 }
                } else {
                    let vector = Vector<1, Int>(InlineArray { $0 + 0 })
                    var reversed = vector.reversed()
                    reversedSum += reversed.reduce.into(0) { $0 += $1 }
                }
            }

            #expect(forwardSum == reversedSum)

}
do {

            var forwardSum = 0
            var reversedSum = 0

            for iteration in 0..<10 {
                if iteration.isMultiple(of: 2) {
                    var vector = Vector<5, Int>(InlineArray { $0 + 0 })
                    forwardSum += vector.reduce.into(0) { $0 += $1 }
                } else {
                    let vector = Vector<5, Int>(InlineArray { $0 + 0 })
                    var reversed = vector.reversed()
                    reversedSum += reversed.reduce.into(0) { $0 += $1 }
                }
            }

            #expect(forwardSum == reversedSum)

}
do {

            var forwardSum = 0
            var reversedSum = 0

            for iteration in 0..<10 {
                if iteration.isMultiple(of: 2) {
                    var vector = Vector<10, Int>(InlineArray { $0 + 0 })
                    forwardSum += vector.reduce.into(0) { $0 += $1 }
                } else {
                    let vector = Vector<10, Int>(InlineArray { $0 + 0 })
                    var reversed = vector.reversed()
                    reversedSum += reversed.reduce.into(0) { $0 += $1 }
                }
            }

            #expect(forwardSum == reversedSum)

}
do {

            var forwardSum = 0
            var reversedSum = 0

            for iteration in 0..<10 {
                if iteration.isMultiple(of: 2) {
                    var vector = Vector<50, Int>(InlineArray { $0 + 0 })
                    forwardSum += vector.reduce.into(0) { $0 += $1 }
                } else {
                    let vector = Vector<50, Int>(InlineArray { $0 + 0 })
                    var reversed = vector.reversed()
                    reversedSum += reversed.reduce.into(0) { $0 += $1 }
                }
            }

            #expect(forwardSum == reversedSum)

}
    }

    @Test
    func `borrowing reduce preserves forward and reversed order`()  {
        let vector = Vector<5, Int>(InlineArray { $0 + 0 })

        #expect(Self.borrowingMaterialize(vector) == [0, 1, 2, 3, 4])
        #expect(Self.borrowingMaterialize(vector.reversed()) == [4, 3, 2, 1, 0])
    }

    @Test
    func `borrowing allSatisfy handles content and emptiness`()  {
        let vector = Vector<5, Int>(InlineArray { $0 + 0 })
        let empty = Vector<0, Int>(InlineArray { $0 + 0 })

        #expect(Self.borrowingAllSatisfy(vector) { $0 >= 0 })
        #expect(!Self.borrowingAllSatisfy(vector) { $0 < 4 })
        #expect(Self.borrowingAllSatisfy(empty) { _ in false })
    }

    private static func borrowingMaterialize<S: Sequenceable & Copyable>(
        _ source: borrowing S
    ) -> [S.Element]
    where S.Element: Copyable & Escapable, S.Iterator.Failure == Never {
        var iterator = (copy source).makeIterator()
        var result: [S.Element] = []
        while let element = iterator.next() { result.append(element) }
        return result
    }

    private static func borrowingAllSatisfy<S: Sequenceable & Copyable>(
        _ source: borrowing S,
        _ predicate: (borrowing S.Element) -> Bool
    ) -> Bool
    where S.Element: Copyable & Escapable, S.Iterator.Failure == Never {
        var iterator = (copy source).makeIterator()
        while let element = iterator.next() {
            if !predicate(element) { return false }
        }
        return true
    }
}

#endif
