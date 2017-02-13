/* *     Copyright 2016, 2017 IBM Corp.
 *     Licensed under the Apache License, Version 2.0 (the "License");
 *     you may not use this file except in compliance with the License.
 *     You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *     Unless required by applicable law or agreed to in writing, software
 *     distributed under the License is distributed on an "AS IS" BASIS,
 *     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *     See the License for the specific language governing permissions and
 *     limitations under the License.
 */

import XCTest

import BMSCore
@testable import AppID
class PreferencesTests: XCTestCase {

    override func setUp() {
    }

    func testStringPreference() {
        
        let s = StringPreference(name: "testPref", sharedPreferences: UserDefaults.standard)
        s.clear()
        XCTAssertNil(s.get())
        s.set("testValue")
        XCTAssertEqual(s.get(), "testValue")
        s.clear()
        XCTAssertNil(s.get())
        
    }
    
    func testJSONPreference() {
        let s = JSONPreference(name: "testJSONPref", sharedPreferences: UserDefaults.standard)
        s.clear()
        XCTAssertNil(s.get())
        XCTAssertNil(s.getAsJSON())
        s.set("testValue")
        XCTAssertEqual(s.get(), "testValue")
        XCTAssertNil(s.getAsJSON())
        s.set("{\"key1\":\"val1\"}")
        XCTAssertEqual(s.get(), "{\"key1\":\"val1\"}")
        var json:[String:Any]? = s.getAsJSON()
        XCTAssertEqual(json?["key1"] as? String, "val1")
        XCTAssertEqual(json?.count, 1)

    }
    
}
    
