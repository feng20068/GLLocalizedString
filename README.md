GLLocalizedString
=================

自定义外部plist文件代替LocalizedString文件

转换方法：可用如下代码将Localized.Strings文件转化为@"Strings_%@.plist",currentLanguage文件
NSArray *languages = [NSLocale preferredLanguages];
    for (NSString *currentLanguage in languages) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"InfoPlist"
                                                         ofType:@"strings"
                                                    inDirectory:nil
                                                forLocalization:currentLanguage];
        
        // compiled .strings file becomes a "binary property list"
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *filePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Strings_%@.plist",currentLanguage ]];
        [dict writeToFile:filePath atomically:YES];
    }
将生成的@"Strings_%@.plist",currentLanguage文件添加到资源文件中，
在应用程序的Info.plist文件中添加UIFileSharingEnabled键，并将键值设置为YES

调用方法，在项目Prefix.pch中添加#import"GLLocalizedString.h"，然后用类似与NSLocalizedString(@"MAINCITY_ACTION", "")的方法使用
GLEELocalizedString(@"MAINCITY_ACTION", "")
可在项目中批量替换NSLocalizedString为GLEELocalizedString