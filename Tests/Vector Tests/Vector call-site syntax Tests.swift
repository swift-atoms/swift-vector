import Vector
import Testing

@Suite struct `Vector construction reads naturally at the call site` {
    @Test func `Named components infer one dimensional vector storage`() {
        let value = Vector(x: 1)
        let typed: Vector<1, Int> = value

        #expect(typed.x == 1)
    }

    @Test func `Named components infer two dimensional vector storage`() {
        let value = Vector(x: 1, y: 2)
        let typed: Vector<2, Int> = value

        #expect(typed.x == 1)
        #expect(typed.y == 2)
    }

    @Test func `Named components infer three dimensional vector storage`() {
        let value = Vector(x: 1, y: 2, z: 3)
        let typed: Vector<3, Int> = value

        #expect(typed.x == 1)
        #expect(typed.y == 2)
        #expect(typed.z == 3)
    }

    @Test func `Context selects the scalar type without repeating generic arguments`() {
        let value: Vector<3, Double> = .init(x: 1, y: 2, z: 3)

        #expect(value.x == 1.0)
        #expect(value.y == 2.0)
        #expect(value.z == 3.0)
    }

    @Test func `A fixed component list supports dimensions beyond named axes`() {
        let value = Vector<8, Double>([1, 2, 3, 4, 5, 6, 7, 8])

        #expect(value[0] == 1.0)
        #expect(value[5] == 6.0)
        #expect(value[7] == 8.0)
    }

    @Test func `Repeated components do not require exposing the storage constructor`() {
        let value = Vector<8, Double>(repeating: 2)

        #expect(value[0] == 2.0)
        #expect(value[7] == 2.0)
    }

    @Test func `Existing storage remains usable without changing representation`() {
        let storage: InlineArray<3, Double> = [1, 2, 3]
        let value = Vector(storage)

        #expect(value == Vector(x: 1.0, y: 2.0, z: 3.0))
    }
}

@Test func `Named vector components mutate the existing storage`() {
    var vector = Vector(x: 1, y: 2, z: 3)
    vector.x = 4
    vector.y = 5
    vector.z = 6

    #expect(vector == Vector<3, Int>([4, 5, 6]))
}
