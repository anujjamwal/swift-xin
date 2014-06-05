//
//  MailboxModel.swift
//  swift-xin
//
//  Created by Dylan Walker Brown on 6/4/14.
//  Copyright (c) 2014 Dylan Walker Brown. All rights reserved.
//

let thinkinOfANumber = 12

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
//    }
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