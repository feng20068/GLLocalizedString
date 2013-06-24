//
//  GLLocalizedString.h
//  fengTools
//
//  Created by feng on 6/21/13.
//  Copyright (c) 2013 feng20068. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GLEELocalizedString(key, comment) \
[[GLLocalizedString shareInstance] localizedStringForKey:(key) value:@""]
#define DEFAULTLANGUAGE @"de"
@interface GLLocalizedString : NSObject
@property (nonatomic,retain) NSDictionary *localizedStringDict;
+(GLLocalizedString*)shareInstance;
-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;
@end
