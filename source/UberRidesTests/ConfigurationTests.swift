//
//  ConfigurationTests.swift
//  UberRides
//
//  Copyright © 2015 Uber Technologies, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import XCTest
@testable import UberRides

class ConfigurationTests: XCTestCase {

    private let defaultClientID = "testClientID"
    private let defaultCallbackString = "testUri://uberConnect"
    private let defaultAccessTokenIdentifier = "RidesAccessTokenKey"
    private let defaultRegion = Region.Default
    private let defaultSandbox = false
    
    override func setUp() {
        super.setUp()
        Configuration.restoreDefaults()
        Configuration.plistName = "testInfo"
        Configuration.bundle = NSBundle(forClass: self.dynamicType)
    }
    
    override func tearDown() {
        Configuration.restoreDefaults()
        super.tearDown()
    }
    
    //MARK: Reset Test
    
    func testConfiguration_restoreDefaults() {
        
        let newClientID = "newID"
        let newCallback = "newCallback://"
        let newGroup = "new group"
        let newTokenId = "newTokenID"
        let newRegion = Region.China
        let newSandbox = true
        
        Configuration.setClientID(newClientID)
        Configuration.setCallbackURIString(newCallback)
        Configuration.setDefaultKeychainAccessGroup(newGroup)
        Configuration.setDefaultAccessTokenIdentifier(newTokenId)
        Configuration.setRegion(newRegion)
        Configuration.setSandboxEnabled(newSandbox)
        
        XCTAssertEqual(newClientID, Configuration.getClientID())
        XCTAssertEqual(newCallback, Configuration.getCallbackURIString())
        XCTAssertEqual(newGroup, Configuration.getDefaultKeychainAccessGroup())
        XCTAssertEqual(newTokenId, Configuration.getDefaultAccessTokenIdentifier())
        XCTAssertEqual(newRegion, Configuration.getRegion())
        XCTAssertEqual(newSandbox, Configuration.getSandboxEnabled())
        Configuration.restoreDefaults()
        
        XCTAssertEqual(Configuration.plistName, "Info")
        XCTAssertEqual(Configuration.bundle, NSBundle.mainBundle())
        
        Configuration.plistName = "testInfo"
        Configuration.bundle = NSBundle(forClass: self.dynamicType)
        
        XCTAssertEqual(Configuration.getClientID(), defaultClientID)
        XCTAssertEqual(defaultCallbackString, Configuration.getCallbackURIString())
        XCTAssertEqual("", Configuration.getDefaultKeychainAccessGroup())
        XCTAssertEqual(defaultAccessTokenIdentifier, Configuration.getDefaultAccessTokenIdentifier())
        XCTAssertEqual(defaultRegion, Configuration.getRegion())
        XCTAssertEqual(defaultSandbox, Configuration.getSandboxEnabled())
    }
    
    //MARK: Client ID Tests
    
    func testClientID_getDefault() {
        XCTAssertEqual(defaultClientID, Configuration.getClientID())
    }
    
    func testClientID_overwriteDefault() {
        let clientID = "clientID"
        Configuration.setClientID(clientID)
        XCTAssertEqual(clientID, Configuration.getClientID())
    }
    
    func testClientID_resetDefault() {
        Configuration.setClientID("alternateClient")
        
        Configuration.setClientID(nil)
        
        XCTAssertEqual(defaultClientID, Configuration.getClientID())
    }
    
    //MARK: Callback URI String Tests
    
    func testCallbackURIString_getDefault() {
        XCTAssertEqual(defaultCallbackString, Configuration.getCallbackURIString())
    }
    
    func testCallbackURIString_overwriteDefault() {
        let callbackURIString = "callback://test"
        Configuration.setCallbackURIString(callbackURIString)
        
        XCTAssertEqual(callbackURIString, Configuration.getCallbackURIString())
    }
    
    func testCallbackURIString_resetDefault() {
        Configuration.setCallbackURIString("testCallback://asdf")
        
        Configuration.setCallbackURIString(nil)
        
        XCTAssertEqual(defaultCallbackString, Configuration.getCallbackURIString())
    }
    
    //MARK: Keychain Access Group Tests
    
    func testDefaultKeychainAccessGroup_getDefault() {
        XCTAssertEqual("", Configuration.getDefaultKeychainAccessGroup())
    }
    
    func testDefaultKeychainAccessGroup_overwriteDefault() {
        let defaultKeychainAccessGroup = "accessGroup"
        Configuration.setDefaultKeychainAccessGroup(defaultKeychainAccessGroup)
        
        XCTAssertEqual(defaultKeychainAccessGroup, Configuration.getDefaultKeychainAccessGroup())
    }
    
    func testDefaultKeychainAccessGroup_resetDefault() {
        Configuration.setDefaultKeychainAccessGroup("accessGroup")
        
        Configuration.setDefaultKeychainAccessGroup(nil)
        
        XCTAssertEqual("", Configuration.getDefaultKeychainAccessGroup())
    }
    
    //MARK: Access token identifier tests
    
    func testDefaultAccessTokenIdentifier_getDefault() {
        XCTAssertEqual(defaultAccessTokenIdentifier, Configuration.getDefaultAccessTokenIdentifier())
    }
    
    func testDefaultAccessTokenIdentifier_overwriteDefault() {
        let newIdentifier = "newIdentifier"
        Configuration.setDefaultAccessTokenIdentifier(newIdentifier)
        
        XCTAssertEqual(newIdentifier, Configuration.getDefaultAccessTokenIdentifier())
    }
    
    func testDefaultAccessTokenIdentifier_resetDefault() {
        Configuration.setDefaultAccessTokenIdentifier("newIdentifier")

        Configuration.setDefaultAccessTokenIdentifier(nil)
        
        XCTAssertEqual(defaultAccessTokenIdentifier, Configuration.getDefaultAccessTokenIdentifier())
    }
    
    //MARK: Region Tests
    
    func testRegion_getDefault() {
        XCTAssertEqual(defaultRegion, Configuration.getRegion())
    }
    
    func testRegion_overwriteDefault() {
        let newRegion = Region.China
        Configuration.setRegion(newRegion)
        
        XCTAssertEqual(newRegion, Configuration.getRegion())
    }
    
    //MARK: Sandbox Tests
    
    func testSandbox_getDefault() {
        XCTAssertEqual(defaultSandbox, Configuration.getSandboxEnabled())
    }
    
    func testSandbox_overwriteDefault() {
        let newSandbox = true
        Configuration.setSandboxEnabled(newSandbox)
        
        XCTAssertEqual(newSandbox, Configuration.getSandboxEnabled())
    }
}
