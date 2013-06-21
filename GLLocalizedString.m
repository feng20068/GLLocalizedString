//
//  GLLocalizedString.m
//  fengTools
//
//  Created by feng on 6/21/13.
//  Copyright (c) 2013 feng20068. All rights reserved.
//

#import "GLLocalizedString.h"

@implementation GLLocalizedString
static GLLocalizedString *gleeLocalizedString;
+(GLLocalizedString *)shareInstance
{
    if (gleeLocalizedString==nil) {
        gleeLocalizedString=[[GLLocalizedString alloc]init];
    }
    return gleeLocalizedString;
}

-(id)init
{
    if(self = [super init]){
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage=[languages objectAtIndex:0];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *filePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Strings_%@.plist",currentLanguage ]];
        //第一次启动，copy资源文件到document目录
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
            for (NSString * language in languages) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
                NSString *resourcePath =[[NSBundle mainBundle]
                                         pathForResource:[NSString stringWithFormat:@"Strings_%@",language]
                                         ofType:@"plist"];
                if ([[NSFileManager defaultManager] fileExistsAtPath:resourcePath])
                {
                     NSString *filePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Strings_%@.plist",language ]];
                    [[NSFileManager defaultManager] copyItemAtPath:resourcePath toPath:filePath error:nil];
                }                
            }
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        }
        
        self.localizedStringDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return self;
}

-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value
{
    
    return [self.localizedStringDict objectForKey:key];
}
@end
