//
//  Fetcher.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "Fetcher.h"
#import "AppDelegate.h"
#import "NewsItemCD+CoreDataClass.h"


@interface Fetcher () <NSXMLParserDelegate>

@property (nonatomic, strong)  NSMutableDictionary* reusableNewsItemDictionary;
@property (nonatomic, strong, readwrite)  AllNews* allNews;


@property (nonatomic, strong)  NSMutableArray* arrayOfNewsDictionaries;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

@end

@implementation Fetcher


BOOL startWritingData = NO;
static NSString* dataURl = @"http://feeds.bbci.co.uk/news/rss.xml?edition=int";
NSMutableString* currentNodeContent;


#pragma mark - Init variables

-(NSMutableArray*) arrayOfNewsDictionaries {
    if (_arrayOfNewsDictionaries == nil) {
        _arrayOfNewsDictionaries = [NSMutableArray new];
    }
    return _arrayOfNewsDictionaries;
}

-(NSManagedObjectContext*) managedObjectContext {
    if (_managedObjectContext == nil) {
        _managedObjectContext = [(AppDelegate*) [UIApplication sharedApplication].delegate getContext];
    }
    return _managedObjectContext;
}

-(AllNews*) allNews {
    if (_allNews == nil) {
        _allNews = [AllNews new];
    }
    return _allNews;
}

-(NSMutableDictionary*) reusableNewsItemDictionary {
    if (_reusableNewsItemDictionary == nil) {
        _reusableNewsItemDictionary = [NSMutableDictionary new];
    }
    return _reusableNewsItemDictionary;
}

#pragma mark - Fetch Methods

-(void) fetchData
{
    [self getResponse:dataURl success:^(NSXMLParser *responseXML) {
        responseXML.delegate = self;
        [responseXML parse];
    }];
}

-(void)getResponse:(NSString *)urlStr success:(void (^)(NSXMLParser *responseXML))success
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                {
                                                    NSXMLParser * xml = [[NSXMLParser alloc] initWithData:data];
                                                    success(xml);
                                                }
                                            }];
    [dataTask resume];
}

#pragma mark - Parser

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate allNewsParsed:self.allNews];
        startWritingData = NO;
    });
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
 
    if ([elementName isEqualToString:@"item"]) {
        // pass dict with one news item
        if (startWritingData && self.reusableNewsItemDictionary.count != 0) {
            // simple model
            [self.allNews addItem:[self.reusableNewsItemDictionary mutableCopy]];
            
            // save news dicts to save them in core data in main thread in the future
            [self.arrayOfNewsDictionaries addObject:[self.reusableNewsItemDictionary mutableCopy]];
            
            //clean reusable dict
            [self.reusableNewsItemDictionary removeAllObjects];
        }
        startWritingData = YES;
    }
    
    if ([elementName isEqualToString:@"media:thumbnail"]) {
        [self.reusableNewsItemDictionary setObject:attributeDict[@"url"] forKey:@"imageURL"];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName  {
    
    if (startWritingData ) {
        if ([elementName isEqualToString:@"title"]) {
            [self.reusableNewsItemDictionary setObject:currentNodeContent forKey:@"title"];
        }
        
        if ([elementName isEqualToString:@"description"]) {
            [self.reusableNewsItemDictionary setObject:currentNodeContent forKey:@"newsDescription"];
        }
        
        if ([elementName isEqualToString:@"link"]) {
            [self.reusableNewsItemDictionary setObject:currentNodeContent forKey:@"newsLink"];
        }
        
        if ([elementName isEqualToString:@"pubDate"]) {
            [self.reusableNewsItemDictionary setObject:currentNodeContent forKey:@"pubDate"];
        }
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
