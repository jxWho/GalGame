//
//  userManager.h
//  galGame
//
//  Created by god on 13-7-27.
//
//

#import <Foundation/Foundation.h>

@interface userManager : NSObject<NSXMLParserDelegate>
{
    NSMutableDictionary *sayContent;
    NSString *sayElementName;
    NSMutableString *bufferString;
    BOOL sayOpen;
    @public
    NSInteger currentCont;
}

@property(nonatomic, retain, getter = getSayArray) NSMutableArray *sayArray;


+ (userManager *) sharedUserManager;

- (void)setCurrentCont:(NSInteger)cnt;

@end
