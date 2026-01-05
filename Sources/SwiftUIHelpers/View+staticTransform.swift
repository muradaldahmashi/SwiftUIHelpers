//
//  View+staticTransform.swift
//  SwiftUIHelpers
//
//  Created by Sam on 2026-01-05.
//  Credit: https://twitter.com/Barbapapapps/status/2002762692801737183/
//

import SwiftUI

extension View {
    /// Conditionally transforms this view based on compile-time checks.
    ///
    /// Use this modifier for conditions that are known at compile time, such as
    /// availability checks, compiler directives, and build configuration flags.
    ///
    /// > Warning: Only use compile-time conditions in the transform closure.
    /// Using runtime state like `@State`, `@Binding`, or computed properties
    /// will break view identity and cause unnecessary view refreshes.
    ///
    /// For example, you can apply different styles based on OS version:
    ///
    ///     Button("Sign In") { }
    ///         .staticTransform { view in
    ///             if #available(iOS 26.0, *) {
    ///                 view.buttonStyle(.glass)
    ///             } else {
    ///                 view.buttonStyle(.bordered)
    ///             }
    ///         }
    ///
    /// Valid compile-time conditions include availability checks
    /// (`if #available(iOS 26.0, *)`), compiler directives (`#if DEBUG`, `#if os(iOS)`),
    /// and build configuration (`#if RELEASE`).
    ///
    /// - Parameter content: A view builder that receives this view and returns
    ///   a transformed version based on compile-time conditions.
    /// - Returns: A view modified according to the compile-time conditions.
    @inlinable
    public func staticTransform<Content: View>(
        @ViewBuilder _ content: @Sendable (_ view: Self) -> Content
    ) -> some View {
        content(self)
    }
}
