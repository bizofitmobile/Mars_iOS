//
//  HanselConfigs.h
//  Hansel
//
//  Created by Akash Nagar on 1/12/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HanselConfigs : NSObject

/*!
 @method
 
 @abstract
 Returns the value for the given string config.
 
 @param key Config name/Key for which the String config is required.
 @param defaultValue  Default value that will be returned in case no value exists for the given key.
 
 @return The string config value for the given key if available. If no config value is available will return the default value.
 
 */

+ (NSString* _Nullable) getString: (NSString* _Nonnull) key withDefaultValue: (NSString* _Nullable) defaultValue NS_SWIFT_NAME(getString(_:withDefaultValue:));

/*!
 @method
 
 @abstract
 Returns the value for the given double config.
 
 @param key  Config name/Key for which the double config is required.
 @param defaultValue  Default value that will be returned in case no value exists for the given key.
 
 @return The double config value for the given key if available. If no config value is available will return the default value.
 
 */

+ (NSNumber* _Nullable) getDouble: (NSString* _Nonnull) key withDefaultValue: (NSNumber* _Nullable) defaultValue NS_SWIFT_NAME(getDouble(_:withDefaultValue:));

/*!
 @method
 
 @abstract
 Returns the value for the given boolean config.
 
 @param key Config name/Key for which the boolean config is required.
 @param defaultValue  Default value that will be returned in case no value exists for the given key.
 
 @return The boolean config value for the given key if available. If no config value is available will return the default value.
 
 */

+ (BOOL) getBool: (NSString* _Nonnull) key withDefaultValue: (BOOL) defaultValue NS_SWIFT_NAME(getBool(_:withDefaultValue:));

/*!
 @method
 
 @abstract
 Returns the value for the given string config.
 
 @param key Config name/Key for which the string config is required.
 
 @return The string config value for the given key if available. If no config value is available will return nil.
 
 */


+ (NSString* _Nullable) getString: (NSString* _Nonnull) key NS_SWIFT_NAME(getString(_:));

/*!
 @method
 
 @abstract
 Returns the value for the given double config.
 
 @param key Config name/Key for which the double config is required.
 
 @return The double config value for the given key if available. If no config value is available will return nil.
 
 */


+ (NSNumber* _Nullable) getDouble: (NSString* _Nonnull) key NS_SWIFT_NAME(getDouble(_:));

/*!
 @method
 
 @abstract
 Returns the value for the given boolean config.
 
 @param key Config name/Key for which the boolean config is required.
 
 @return The boolean config value for the given key if available. If no config value is available will return NO.
 
 */


+ (BOOL) getBool: (NSString* _Nonnull) key NS_SWIFT_NAME(getBool(_:));

@end
