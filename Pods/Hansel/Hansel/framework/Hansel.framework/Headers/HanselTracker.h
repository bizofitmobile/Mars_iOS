//
//  HanselTracker.h
//  Pods
//
//  Created by Akash Nagar on 8/7/17.
//
//

#import <Foundation/Foundation.h>

@protocol HanselEventsListener;

@class HanselProperties;

@interface HanselTracker : NSObject

/*!
 @method
 
 @abstract
 Set the events listener with Hansel SDK.
 
 @discussion
 Hansel SDK needs to send some events to analyze user behavior. These events need to be fired to your analytics vendor. Please fire these events to only one analytics vendor. To allow Hansel SDK to send events, implement HanselEventsListener protocol and register the reference of the object with Hansel SDK. At any point of time there can only be one events listener registered with Hansel SDK.
 
 @param listener  Instance of a class implementing the HanselEventsListener protocol.
 
 */

+ (void) registerListener: (id<HanselEventsListener>_Nonnull) listener NS_SWIFT_NAME(registerListener(_:));

/*!
 @method
 
 @abstract
 Remove the events listener from Hansel SDK.
 
 @discussion
 Remove the events listener from Hansel SDK already registered with Hansel SDK. Please don't do this unless you wish to register another listener with the Hansel SDK.
 
 */

+ (void) deRegisterListener NS_SWIFT_NAME(deRegisterListener());

/*!
 @method
 
 @abstract
 Get the Hansel Data for the given event.
 
 @discussion
 Call this method to get the Hansel Data. Append the data returned by this method to the another properties that you intend to send to your analytics vendor.
 
 @param eventName   Event to be tracked
 @param vendor      Vendor for the given event.
 @param properties  Event properties
 
 @return A dictionary containing the analytics data.
 
 */

+ (NSDictionary* _Nonnull) getHanselData: (NSString* _Nonnull) eventName andVendor: (NSString* _Nonnull) vendor withProperties: (NSDictionary*_Nullable) properties NS_SWIFT_NAME(getHanselData(_:vendor:withProperties:));

/*!
 @method
 
 @abstract
 Checks whether the event is tracked by any of the Maps on the Hansel dashboard.
 
 @param event       Event to be tracked
 @param vendor      Vendor for the given event
 @param properties  Event properties
 
 @return True if the event is tracked by any of the Maps on Hansel Dashboard, False otherwise.
 
 */

+ (BOOL) isUsedInMap: (NSString* _Nonnull) event andVendor: (NSString* _Nonnull) vendor withProperties: (NSDictionary* _Nullable) properties NS_SWIFT_NAME(isUsedInMap(_:vendor:withProperties:));

@end

