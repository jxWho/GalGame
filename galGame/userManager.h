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
    float musicVolume;
}


@property(nonatomic, retain, getter = getSayArray) NSMutableArray *sayArray;
@property(nonatomic, retain, getter = getCharacterArray) NSMutableArray *characterArray;


+ (userManager *) sharedUserManager;
+ (void)destoryUserManager;

- (void)setCurrentCont:(NSInteger)cnt;

@end
