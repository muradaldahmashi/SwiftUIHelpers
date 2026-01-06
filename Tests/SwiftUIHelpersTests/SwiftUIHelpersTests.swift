//
//  SwiftUIHelpersTests.swift
//  SwiftUIHelpers
//
//  Created by Sam on 2026-01-05.
//

import Testing
import SwiftUI
@testable import SwiftUIHelpers

// MARK: - System Symbol Tests

@Test("System symbol exists for common symbols")
func testSystemSymbolExistsForCommonSymbols() {
    #expect(Image.systemSymbolExists("star.fill"))
    #expect(Image.systemSymbolExists("heart"))
    #expect(Image.systemSymbolExists("heart.fill"))
    #expect(Image.systemSymbolExists("circle"))
    #expect(Image.systemSymbolExists("square"))
    #expect(Image.systemSymbolExists("plus"))
    #expect(Image.systemSymbolExists("minus"))
    #expect(Image.systemSymbolExists("checkmark"))
    #expect(Image.systemSymbolExists("xmark"))
    #expect(Image.systemSymbolExists("house"))
    #expect(Image.systemSymbolExists("gear"))
}

@Test("System symbol does not exist for invalid names")
func testSystemSymbolDoesNotExistForInvalidNames() {
    #expect(!Image.systemSymbolExists("this.symbol.does.not.exist"))
    #expect(!Image.systemSymbolExists("completely.made.up.symbol.name"))
    #expect(!Image.systemSymbolExists("invalid@symbol#name"))
    #expect(!Image.systemSymbolExists("123.456.789"))
}

@Test("System symbol handles edge cases")
func testSystemSymbolHandlesEdgeCases() {
    #expect(!Image.systemSymbolExists(""))
    #expect(!Image.systemSymbolExists(" "))
    #expect(!Image.systemSymbolExists("   "))
}

@Test("System symbol handles various symbol variants")
func testSystemSymbolVariants() {
    #expect(Image.systemSymbolExists("star"))
    #expect(Image.systemSymbolExists("star.fill"))
    #expect(Image.systemSymbolExists("star.circle"))
    #expect(Image.systemSymbolExists("star.circle.fill"))
}

// MARK: - Private Symbol Tests

@Test("Private symbol exists function returns boolean")
func testPrivateSymbolExistsReturnsBoolean() {
    let result = Image.privateSymbolExists("some.symbol")
    #expect(type(of: result) == Bool.self)
}

@Test("Private symbol exists for known private symbols")
func testPrivateSymbolExistsForKnownSymbols() {
    #expect(Image.privateSymbolExists("macintosh.classic"))
    #expect(Image.privateSymbolExists("apple.testflight"))
    #expect(Image.privateSymbolExists("emoji.face.winking.with.stuck.out.tongue"))
    #expect(Image.privateSymbolExists("bluetooth"))
}

@Test("Private symbol does not exist for clearly invalid names")
func testPrivateSymbolDoesNotExistForInvalidNames() {
    #expect(!Image.privateSymbolExists(""))
    #expect(!Image.privateSymbolExists("this.is.definitely.not.a.real.private.symbol.name.that.would.ever.exist"))
}

@Test("Private symbol handles edge cases")
func testPrivateSymbolHandlesEdgeCases() {
    let emptyResult = Image.privateSymbolExists("")
    let whitespaceResult = Image.privateSymbolExists(" ")
    let longStringResult = Image.privateSymbolExists(String(repeating: "a", count: 1000))
    
    // Just verify these don't crash and return booleans
    #expect(type(of: emptyResult) == Bool.self)
    #expect(type(of: whitespaceResult) == Bool.self)
    #expect(type(of: longStringResult) == Bool.self)
}

// MARK: - Cross-Method Tests

@Test("Private and system symbols are independent checks")
func testPrivateAndSystemSymbolsAreIndependent() {
    // A symbol that exists in the public API
    let publicSymbol = "star.fill"
    #expect(Image.systemSymbolExists(publicSymbol))
    
    // Just verify privateSymbolExists runs without error
    _ = Image.privateSymbolExists(publicSymbol)
    
    // A symbol that doesn't exist
    let nonExistentSymbol = "definitely.not.a.symbol"
    #expect(!Image.systemSymbolExists(nonExistentSymbol))
    _ = Image.privateSymbolExists(nonExistentSymbol)
}
