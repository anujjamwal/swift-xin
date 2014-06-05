//
//  MailboxModel.swift
//  swift-xin
//
//  Created by Dylan Walker Brown on 6/4/14.
//  Copyright (c) 2014 Dylan Walker Brown. All rights reserved.
//

let keychain_item = "OAuth 2.0 Gmail Session"
let kClientID = "190459256876-uj0j7opothq6929pku0s3kv0ah81bj62.apps.googleusercontent.com"
let kClientSecret = "fQwtS74uZZMe_VkTIJ4gDeUS"

class Mailbox {
    
    var masterViewController: ViewController
    var email: String?
    var accessToken: String?
    var auth: GTMOAuth2Authentication?
    var imapSession = MCOIMAPSession()
    
    init (owner: ViewController) {
        self.masterViewController = owner
        self.startOAuth2()
    }
    
    // Initiate the login process
    func startOAuth2() {
        
        // Load authentication from keychain if possible
        var auth: GTMOAuth2Authentication = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(keychain_item, clientID: kClientID, clientSecret: kClientSecret)
        
        // If there is no authentication token available, push a login view controller
        if !auth.refreshToken {
            var authViewController = GTMOAuth2ViewControllerTouch(scope: "https://mail.google.com", clientID: kClientID, clientSecret: kClientSecret, keychainItemName: keychain_item, delegate: self, finishedSelector: "viewController:finishedWithAuth:error:")
            self.masterViewController.navigationController.pushViewController(authViewController, animated: true)
        } else {
            auth.beginTokenFetchWithDelegate(self, didFinishSelector: "auth:finishedRefreshWithFetcher:error:")
        }
    }
    
    func auth(authorization: GTMOAuth2Authentication, finishedRefreshWithFetcher: GTMHTTPFetcher, error: NSError?) {
        self.viewController(nil, finishedWithAuth: authorization, error: error)
    }
    
    // Dismiss the login modal view controller
    func viewController(vc: GTMOAuth2ViewControllerTouch?, finishedWithAuth: GTMOAuth2Authentication, error: NSError?) {
        if error {
            // Authentication failed
        } else {
            // Authentication success
            self.auth = finishedWithAuth
            vc?.dismissModalViewControllerAnimated(true)
            
            self.email = finishedWithAuth.userEmail
            self.accessToken = finishedWithAuth.accessToken
            self.imapSession = MCOIMAPSession()
            self.imapSession.authType = MCOAuthTypeXOAuth2
            self.imapSession.OAuth2Token = accessToken
            self.imapSession.username = email
        }
    }
    
    // Logout
    func logout() {
        GTMOAuth2ViewControllerTouch.removeAuthFromKeychainForName(keychain_item)
        GTMOAuth2ViewControllerTouch.revokeTokenForGoogleAuthentication(self.auth)
    }
}

//- (void) startOAuth2
//{
//    GTMOAuth2Authentication * auth = [GTMOAuth2WindowController authForGoogleFromKeychainForName:KEYCHAIN_ITEM_NAME
//        clientID:CLIENT_ID
//        clientSecret:CLIENT_SECRET];
//    
//    if ([auth refreshToken] == nil) {
//        GTMOAuth2WindowController *windowController =
//            [[GTMOAuth2WindowController alloc] initWithScope:@"https://mail.google.com/"
//        clientID:CLIENT_ID
//        clientSecret:CLIENT_SECRET
//        keychainItemName:KEYCHAIN_ITEM_NAME
//        resourceBundle:[NSBundle bundleForClass:[GTMOAuth2WindowController class]]];
//        [windowController autorelease];
//        [windowController signInSheetModalForWindow:nil
//        delegate:self
//        finishedSelector:@selector(windowController:finishedWithAuth:error:)];
//    }
//    else {
//        [auth beginTokenFetchWithDelegate:self
//            didFinishSelector:@selector(auth:finishedRefreshWithFetcher:error:)];
//    }
//}
//    
//    - (void)auth:(GTMOAuth2Authentication *)auth
//finishedRefreshWithFetcher:(GTMHTTPFetcher *)fetcher
//error:(NSError *)error {
//    [self windowController:nil finishedWithAuth:auth error:error];
//    }
//    
//    - (void)windowController:(GTMOAuth2WindowController *)viewController
//finishedWithAuth:(GTMOAuth2Authentication *)auth
//error:(NSError *)error
//{
//    if (error != nil) {
//        // Authentication failed
//        return
//    }
//    
//    NSString * email = [auth userEmail];
//    NSString * accessToken = [auth accessToken];
//    
//    MCOIMAPSession * imapSession = [[MCOIMAPSession alloc] init];
//    [imapSession setAuthType:MCOAuthTypeXOAuth2];
//    [imapSession setOAuth2Token:accessToken];
//    [imapSession setUsername:email];
//    
//    MCOSMTPSession * smtpSession = [[MCOSMTPSession alloc] init];
//    [smtpSession setAuthType:MCOAuthTypeXOAuth2];
//    [smtpSession setOAuth2Token:accessToken];
//    [smtpSession setUsername:email];
//}