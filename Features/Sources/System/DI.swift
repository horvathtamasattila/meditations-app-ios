import SwiftUI
import Swinject
import SwinjectAutoregistration

public class DI {
    static var assembler: Assembler!

    public static func initialize(assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        // swiftlint:disable:next force_unwrapping
        assembler.resolver.resolve(type)!
    }
}

public extension View {
    static func inject<T>(_: T.Type) -> T {
        return DI.assembler.resolver ~> T.self
    }

    static func inject<T, Arg1>(_: T.Type, argument: Arg1) -> T {
        // swiftlint:disable:next force_unwrapping
        return DI.assembler.resolver.resolve(T.self, argument: argument)!
    }

    static func inject<T, Arg1, Arg2>(_: T.Type, arg1: Arg1, arg2: Arg2) -> T {
        return DI.assembler.resolver ~> (T.self, arguments: (arg1, arg2))
    }

    static func inject<T, Arg1, Arg2, Arg3>(_: T.Type,
                                            arg1: Arg1,
                                            arg2: Arg2,
                                            arg3: Arg3) -> T
    {
        return DI.assembler.resolver ~> (T.self, arguments: (arg1, arg2, arg3))
    }
}
