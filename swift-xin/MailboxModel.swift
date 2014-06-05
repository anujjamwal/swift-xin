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

class Mailbox: NSObject {
    
    var masterViewController: ViewController
    var email: String?
    var accessToken: String?
    var auth: GTMOAuth2Authentication?
    var imapSession = MCOIMAPSession()
    var smtpSession = MCOSMTPSession()
    
    init (owner: ViewController) {
        self.masterViewController = owner
        super.init()
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

            self.imapSession.authType = MCOAuthTypeXOAuth2
            self.imapSession.OAuth2Token = accessToken
            self.imapSession.username = email
            self.imapSession.hostname = "imap.gmail.com"
            self.imapSession.port = 993
            self.imapSession.connectionType = MCOConnectionTypeTLS
            
            self.smtpSession.authType = MCOAuthTypeXOAuth2
            self.smtpSession.OAuth2Token = accessToken
            self.smtpSession.username = email
            
            self.fetchInboxMessages()
        }
    }
    
    // Logout
    func logout() {
        GTMOAuth2ViewControllerTouch.removeAuthFromKeychainForName(keychain_item)
        GTMOAuth2ViewControllerTouch.revokeTokenForGoogleAuthentication(self.auth)
        self.startOAuth2()
    }
    
    // Fetch inbox messages
    func fetchInboxMessages() {
        var requestKind: MCOIMAPMessagesRequestKind = MCOIMAPMessagesRequestKindHeaders
        var folder = "INBOX"
        var uids: MCOIndexSet = MCOIndexSet(range: MCORangeMake(1, UINT64_MAX))

        var fetchOperation: MCOIMAPFetchMessagesOperation = self.imapSession.fetchMessagesByUIDOperationWithFolder(folder, requestKind: requestKind, uids: uids)
        fetchOperation.start({error, fetchedMessages, vanishedMessages in
            //Let's check if there was an error:
            if (error) {
                println("Error downloading message headers: \(error)")
            } else {
                //And, let's print out the messages...
                println("The post man delivereth: \(fetchedMessages)")
            }
        })
    }
}
