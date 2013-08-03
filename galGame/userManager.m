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


+(userManager *) sharedUserManager
{
    if( sharedUser == nil )
        sharedUser = [[userManager alloc]init];
    return sharedUser;
}

- (id)init
{
    if( self = [super init] ){
        currentCont = 1;
        
        sayOpen = NO;
        sayContent = [[NSMutableDictionary alloc]init];
        
        NSString *sayUrl = [[NSBundle mainBundle] pathForResource:@"say" ofType:@"xml"];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sayUrl]];
        [parser setDelegate:self];
        [parser setShouldProcessNamespaces:NO];
        [parser setShouldReportNamespacePrefixes:NO];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
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



#pragma mark -
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
//    NSLog(@"<%@>", elementName);
    sayOpen = YES;
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
    if( [elementName isEqualToString:@"say"] ){
        sayOpen = NO;
        [self.sayArray addObject:sayContent];
        sayContent = [[NSMutableDictionary alloc]init];
    }else{
        [sayContent setObject:bufferString forKey:sayElementName];
    }
}

@end
