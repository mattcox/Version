//
//  Version.swift
//  Version
//
//  Created by Matt Cox on 32/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import Foundation

/// A version number, represented as a major, minor and an optional patch.
///
public struct Version: Sendable {
/// The major version number.
///
/// For example `1.2.0` it is `1`.
///
	public let major: Int

/// The minor version number.
///
/// For example `1.2.0` it is `2`.
///
	public let minor: Int?

/// The patch version number.
///
/// For example `1.2.0` it is `0`.
///
	public let patch: Int?
	
/// The version as a string.
///
	public var string: String {
		if let minor {
			if let patch {
				return "\(self.major).\(minor).\(patch)"
			}
			else {
				return "\(self.major).\(minor)"
			}
		}
		else {
			return "\(self.major)"
		}
	}
	
/// The version number of the current application, if available.
///
	static var current: Version? {
		guard let bundleShortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
			return nil
		}

		return Version(bundleShortVersion)
	}

/// Initialize the version with a major, minor and optional patch number.
///
/// - Parameters:
///   - major: The major version number.
///   - minor: An optional minor version number.
///   - patch: An optional patch version number.
///
	public init(_ major: Int, _ minor: Int? = nil, _ patch: Int? = nil) {
		self.major = major
		self.minor = minor
		self.patch = patch
	}

/// Initalize the version with a string representing a version.
///
/// For example, this demonstrates how to convert a version string into a
/// version.
/// ```
/// let version = Version(fromString: "1.2.3")
///
/// print(version.major)
/// // "1"
///
/// print(version.minor)
/// // "2"
///
/// print(version.patch ?? 0)
/// // "3"
/// ```
///
/// - Note: A string containing 1.2v32, will be converted into 1 and 232,
/// so care should be taken to only use valid seperators.
///
/// - Parameters:
///   - string: The string to convert to a version object.
///
	public init(_ string: String) {
		// Seperate the version string by the "." character, then convert each
		// component into an integer, discarding any non-numeric characters.
		//
		// For example a string containing 1.2.34 would be converted into:
		// 1, 2 and 32. However, a string containing 1.2v32, would be converted
		// into 1 and 232, so care should be taken to use correct version number
		// strings.
		//
		let components: [Int] = string
			.components(separatedBy: ".")
			.compactMap {
				let filteredString = $0.filter("0123456789".contains)
				if filteredString.isEmpty == false {
					return Int(filteredString)
				}
				return nil
			}

		// Populate the version numbers using the components from the parsed
		// string. A default value of 0 is assumed for any missing components.
		// A patch number is only
		//
		switch components.count {
			case 0:
				self.major = 0
				self.minor = nil
				self.patch = nil
			case 1:
				self.major = components[0]
				self.minor = nil
				self.patch = nil
			case 2:
				self.major = components[0]
				self.minor = components[1]
				self.patch = nil
			default:
				self.major = components[0]
				self.minor = components[1]
				self.patch = components[2]
		}
	}
}

extension Version: Codable {
	public init(from decoder: Decoder) throws {
		self = Version(try decoder.singleValueContainer().decode(String.self))
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(self.string)
	}
}

extension Version: Comparable {
	public static func < (lhs: Version, rhs: Version) -> Bool {
		if lhs.major < rhs.major {
			return true
		}
		else if lhs.major > rhs.major {
			return false
		}
		
		if (lhs.minor ?? 0) < (rhs.minor ?? 0) {
			return true
		}
		else if (lhs.minor ?? 0) > (rhs.minor ?? 0) {
			return false
		}
		
		if (lhs.patch ?? 0) < (rhs.patch ?? 0) {
			return true
		}

		return false
	}
	
	public static func <= (lhs: Version, rhs: Version) -> Bool {
		if lhs == rhs {
			return true
		}
	
		return lhs < rhs
	}
	
	public static func > (lhs: Version, rhs: Version) -> Bool {
		if lhs.major > rhs.major {
			return true
		}
		else if lhs.major < rhs.major {
			return false
		}
		
		if (lhs.minor ?? 0) > (rhs.minor ?? 0) {
			return true
		}
		else if (lhs.minor ?? 0) < (rhs.minor ?? 0) {
			return false
		}
		
		if (lhs.patch ?? 0) > (rhs.patch ?? 0) {
			return true
		}

		return false
	}
	
	public static func >= (lhs: Version, rhs: Version) -> Bool {
		if lhs == rhs {
			return true
		}
	
		return lhs > rhs
	}
}

extension Version: CustomStringConvertible {
	public var description: String {
		string
	}
}

extension Version: Equatable {
	
}
