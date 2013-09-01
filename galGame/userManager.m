//
//  userManager.m
//  galGame
//
//  Created by god on 13-7-27.
//
//

#import "userManager.h"

static userManager *sharedUser = nil;

@implementation userManager

@synthesize sayArray = _sayArray;
@synthesize characterArray = _characterArray;


+(userManager *) sharedUserManager
{
    if( sharedUser == nil )
        sharedUser = [[userManager alloc]init];
    return sharedUser;
}

+ (void)destoryUserManager
{
    if( sharedUser )
        sharedUser = nil;
}

- (id)init
{
    if( self = [super init] ){
        currentCont = 1;
        
        sayOpen = YES;
        sayContent = [[NSMutableDictionary alloc]init];
        
        NSString *sayUrl = [[NSBundle mainBundle] pathForResource:@"say" ofType:@"xml"];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sayUrl]];
        [parser setDelegate:self];
        [parser setShouldProcessNamespaces:NO];
        [parser setShouldReportNamespacePrefixes:NO];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
        
        sayOpen = NO;
        NSString *characterUrl = [[NSBundle mainBundle] pathForResource:@"characters" ofType:@"xml"];
        NSXMLParser *parser2 = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL fileURLWithPath:characterUrl]];
        [parser2 setDelegate:self];
        [parser2 setShouldProcessNamespaces:NO];
        [parser2 setShouldReportNamespacePrefixes:NO];
        [parser2 setShouldResolveExternalEntities:NO];
        [parser2 parse];
        
//        NSString *p = @"@Question##1#kkk";
//        NSArray *array = [p componentsSeparatedByString:@"#"];
//        for( int i = 0; i < [array count]; i++ )
//            NSLog(@"sub is %@", [array objectAtIndex:i]);
    }
    return self;
}

- (void)setCurrentCont:(NSInteger)cnt
{
    currentCont = cnt;
}

- (NSMutableArray *) getSayArray
{
    if( _sayArray == nil ){
        _sayArray = [[NSMutableArray alloc]init];
        [_sayArray addObject:[NSNumber numberWithInt:0]];
    }
    return _sayArray;
}

- (NSMutableArray *) getCharacterArray
{
    if( _characterArray == nil )
        _characterArray = [[NSMutableArray alloc]init];
    return _characterArray;
}

#pragma mark -
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
//    NSLog(@"<%@>", elementName);

    sayElementName = elementName;
    bufferString = [[NSMutableString alloc]init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@", string);
    if( ![string isEqualToString:@"\n"] )
        [bufferString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    NSLog(@"<%@/>",elementName);
    if( sayOpen == YES ){
        
        if( [elementName isEqualToString:@"say"] ){

            [self.sayArray addObject:sayContent];
            sayContent = [[NSMutableDictionary alloc]init];
        }else{
            [sayContent setObject:bufferString forKey:sayElementName];
        }
//        NSLog(@"1");
    }else{
        
        if( [elementName isEqualToString:@"characters"] ){
            [self.characterArray addObject:sayContent];
            sayContent = [[NSMutableDictionary alloc]init];
        }else{
            [sayContent setObject:bufferString forKey:sayElementName];
        }
        
    }
}

@end
