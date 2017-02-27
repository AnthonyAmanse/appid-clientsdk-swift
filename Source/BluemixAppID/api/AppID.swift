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

import Foundation
import SafariServices
import BMSCore
public class AppID {

	private(set) var tenantId: String?
	private(set) var bluemixRegion: String?
    private(set) var oauthManager: OAuthManager?
    public var loginWidget: LoginWidgetImpl?
    public var userAttributeManager:UserAttributeManagerImpl?
    
    public static var overrideServerHost: String?
    public static var overrideAttributesHost: String?
    public static var sharedInstance = AppID()
    internal static let logger =  Logger.logger(name: AppIDConstants.AppIDLoggerName)
    
    internal init() {}
    
    
    public func initialize(tenantId: String, bluemixRegion: String) {
        self.tenantId = tenantId
        self.bluemixRegion = bluemixRegion
		self.oauthManager = OAuthManager(appId: self)
        self.loginWidget = LoginWidgetImpl(oauthManager: self.oauthManager!)
        self.userAttributeManager = UserAttributeManagerImpl(appId: self)
    }
	
    public func loginAnonymously(authorizationDelegate:AuthorizationDelegate) {
        self.loginAnonymously(accessTokenString: nil, authorizationDelegate: authorizationDelegate)
    }
    
    public func loginAnonymously(accessTokenString:String?, authorizationDelegate:AuthorizationDelegate) {
        self.loginAnonymously(accessTokenString: accessTokenString, allowCreateNewAnonymousUsers: true, authorizationDelegate: authorizationDelegate)
    }
    
    public func loginAnonymously(accessTokenString:String?, allowCreateNewAnonymousUsers: Bool, authorizationDelegate:AuthorizationDelegate) {
        oauthManager?.authorizationManager?.loginAnonymously(accessTokenString: accessTokenString, allowCreateNewAnonymousUsers: allowCreateNewAnonymousUsers, authorizationDelegate: authorizationDelegate)
    }
    
	public func application(_ application: UIApplication, open url: URL, options :[UIApplicationOpenURLOptionsKey: Any]) -> Bool {
            return (self.oauthManager?.authorizationManager?.application(application, open: url, options: options))!
    }
    
    
       
}
