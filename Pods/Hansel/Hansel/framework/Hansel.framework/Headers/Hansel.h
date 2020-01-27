//
//  Hansel.h
//  pebbletraceiossdk
//
//  Created by Prabodh Prakash on 25/05/16.
//  Copyright © 2016 Hansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanselUser.h"
#import "HanselSyncStateListener.h"
#import "RequestTypeEnum.h"
#import "HanselActionListener.h"

@interface Hansel : NSObject
/*!
 @method
 
 @abstract
 Initializes the hansel sdk.
 
 @discussion
 This method will initialize the hansel SDK. This method should be called in the didFinishLaunchingWithOptions method in the AppDelegate class.
 
 @param appId   The App ID of this app given on the hansel dashboard.
 @param appKey  The App Key of this app given on the hansel dashboard.
 
 */
+ (void) initializeSDKWithAppID: (NSString* _Nonnull) appId andAppKey: (NSString* _Nonnull) appKey NS_SWIFT_NAME(initializeSDK(_:_:));

/*!
 @method
 
 @abstract
 Checks whether the pushPayload was sent by Hansel.
 
 @discussion
 This method will verify whether the pushPayload received by the app was sent from Hansel. This method should be called before passing the payload to Hansel SDK.
 
 @param pushPayload  The payload received from APNS.
 
 @return true if the given push payload is from Hansel
 false otherwise
 
 */

+ (BOOL) isPushFromHansel: (NSDictionary* _Nullable) pushPayload NS_SWIFT_NAME(isHanselPush(userInfo:));

/*!
 @method
 
 @abstract
 Handles the push payload
 
 @param pushPayload  The payload received from APNS.
 
 @return true if Hansel handled the push payload (if it was a hansel push)
 false otherwise
 
*/


+ (BOOL) handlePushPayload: (NSDictionary* _Nullable) pushPayload NS_SWIFT_NAME(handlePushPayload(userInfo:));


/*!
 @method
 
 @abstract
 Sets the APNS token in Hansel SDK.
 
 @param token  The token received from APNS.
 
 */


+ (void) setNewToken: (NSData* _Nullable) token NS_SWIFT_NAME(setNewToken(_:));

/*!
 @method
 
 @abstract
 This method will give the leaf node ID of all interaction map for the current user.
 
 @return  A Dictionary of all Interaction maps. The dictionary will have Interaction Map ID as key and corresponding LeafNodeId for the current user as value.
 
 */

+ (NSDictionary* _Nonnull) getMaps NS_SWIFT_NAME(getMaps());

/*!
 @method
 
 @abstract
 This method will return an user object. Use this object to set the user attributes.
 
 @return The User object.
 
 */

+ (HanselUser* _Nullable) getUser NS_SWIFT_NAME(getUser());


/*!
 @method
 
 @abstract
 Set the sync listener for receiving call backs from Hansel SDK.
 
 @discussion
 Whenever required Hansel SDK syncs values from Hansel backend. If you wish to receive a call back when the syncing is completed. Then implement the protocol HanselSyncStateListener and register an instance of that class with Hansel SDK. Only one listener can be registered for a requestType.
 
 
 @param listener    Instance of a class implementing the HanselSyncStateListener protocol.
 @param requestType An enum for the request type that you are interested in. Currently the values supported are Configs.
 
 */

+ (void) setHanselSyncStateListener:(id<HanselSyncStateListener> _Nonnull) listener forRequest: (RequestType) requestType NS_SWIFT_NAME(setHanselSyncStateListener(_:forRequest:));

/*!
 @method
 
 @abstract
 Remove the sync listener from receiving call backs from Hansel SDK.
 
 @discussion
 For the given request type remove the listener from Hansel SDK.
 
 @param requestType An enum for the request type that you are interested in. Currently the values supported are Configs.
 
 */


+ (void) removeHanselSyncStateListenerForRequest: (RequestType) requestType NS_SWIFT_NAME(removeHanselSyncStateListenerForRequest(_:));


/*!
 @method
 
 @abstract
 Set the action listener for receiving call backs from Hansel SDK whenever an action is performed.
 
 @discussion
 Whenever an action which is configured Hansel Dashboard is performed this listener will get a callback. Implement the protocol HanselActionListener and register an instance of that class with Hansel SDK. You have to register a listener for every action that you would like to track. You can only register one listener for each action. We maintain a weak reference to the listener to avoid memory leaks.
 
 @param action      Name of the action performed
 @param listener    Instance of a class implementing the HanselActionListener protocol.
 
 */

+ (void) registerHanselActionListener: (NSString*_Nonnull) action andListener: (id<HanselActionListener>_Nonnull) listener NS_SWIFT_NAME(registerHanselActionListener(action:listener:));


/*!
 @method
 
 @abstract
 Remove the listener for an action.
 
 @param action      Name of the action performed
 
 */

+ (void) removeHanselActionListener: (NSString*_Nonnull) action NS_SWIFT_NAME(removeHanselActionListener(action:));


/*!
 @method
 
 @abstract
 Set the appFont so that it can used in prompts. If no appFont is set then System Font will be used whenever App Font is selected. Set the font wherever Hansel SDK is initialized.
 
 @param fontFamily  The font family of the font.
 
 */

+ (void) setAppFont: (NSString* _Nonnull) fontFamily NS_SWIFT_NAME(setAppFont(_:));

@end
