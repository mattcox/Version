//
//  VersionTests.swift
//  Version
//
//  Created by Matt Cox on 32/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import XCTest
@testable import Version

final class VersionTests: XCTestCase {
/// Tests the `init(fromString:)` initializer on the `Version` type.
///
	func testInitFromString() throws {
		let invalidVersion = Version("Invalid")
		XCTAssertEqual(invalidVersion.major, 0)
		XCTAssertNil(invalidVersion.minor)
		XCTAssertNil(invalidVersion.patch)
	
		let versionMajorOnly = Version("1")
		XCTAssertEqual(versionMajorOnly.major, 1)
		XCTAssertNil(versionMajorOnly.minor)
		XCTAssertNil(versionMajorOnly.patch)
		
		let versionMajorMinorOnly = Version("1.2")
		XCTAssertEqual(versionMajorMinorOnly.major, 1)
		XCTAssertNotNil(versionMajorMinorOnly.minor)
		XCTAssertEqual(versionMajorMinorOnly.minor ?? -1, 2)
		XCTAssertNil(versionMajorMinorOnly.patch)
		
		let versionMajorMinorPatch = Version("1.2.3")
		XCTAssertEqual(versionMajorMinorPatch.major, 1)
		XCTAssertNotNil(versionMajorMinorPatch.minor)
		XCTAssertEqual(versionMajorMinorPatch.minor ?? -1, 2)
		XCTAssertNotNil(versionMajorMinorPatch.patch)
		XCTAssertEqual(versionMajorMinorPatch.patch ?? -1, 3)
	}

/// Tests the `init(major:,minor:,patch:)` initializer on the `Version` type.
///
	func testInitMajorMinorPatch() throws {
		let versionMajorOnly = Version(1)
		XCTAssertEqual(versionMajorOnly.major, 1)
		XCTAssertNil(versionMajorOnly.minor)
		XCTAssertNil(versionMajorOnly.patch)
		
		let versionMajorMinorOnly = Version(1, 2)
		XCTAssertEqual(versionMajorMinorOnly.major, 1)
		XCTAssertNotNil(versionMajorMinorOnly.minor)
		XCTAssertEqual(versionMajorMinorOnly.minor ?? -1, 2)
		XCTAssertNil(versionMajorMinorOnly.patch)
		
		let versionMajorMinorPatch = Version(1, 2, 3)
		XCTAssertEqual(versionMajorMinorPatch.major, 1)
		XCTAssertNotNil(versionMajorMinorPatch.minor)
		XCTAssertEqual(versionMajorMinorPatch.minor ?? -1, 2)
		XCTAssertNotNil(versionMajorMinorPatch.patch)
		XCTAssertEqual(versionMajorMinorPatch.patch ?? -1, 3)
	}
	
/// Tests the comparable conformance of the `Version` type.
///
	func testComparable() throws {
		let version0_0_0 = Version(0, 0, 0)
		let version0_1_0 = Version(0, 1, 0)
		let version0_1_1 = Version(0, 1, 1)
		let version1_0_0 = Version(1, 0, 0)
		let version1_1_0 = Version(1, 1, 0)
		let version1_1_1 = Version(1, 1, 1)
		
		XCTAssertTrue(version1_0_0 <= version1_0_0)
		XCTAssertTrue(version0_0_0 < version1_0_0)
		XCTAssertTrue(version0_0_0 < version0_1_0)
		XCTAssertTrue(version0_0_0 < version0_1_1)
		
		XCTAssertTrue(version1_1_1 >= version1_0_0)
		XCTAssertTrue(version1_0_0 > version0_0_0)
		XCTAssertTrue(version1_1_0 > version0_1_0)
		XCTAssertTrue(version1_1_1 > version0_1_1)
	}
}
