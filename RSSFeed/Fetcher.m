//
//  Fetcher.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "Fetcher.h"
#import "NewsItem.h"

@interface Fetcher () <NSXMLParserDelegate>

@property (nonatomic, strong)  NSMutableDictionary* currentNewsItemDictionary;
@property (nonatomic, strong, readwrite)  AllNews* allNews;

@end

@implementation Fetcher

BOOL startWritingData = NO;
static NSString* dataURl = @"http://feeds.bbci.co.uk/news/rss.xml?edition=int";
NSMutableString* currentNodeContent;

#pragma mark - Init variables

-(AllNews*) allNews {
    if (_allNews == nil) {
        _allNews = [AllNews new];
    }
    return _allNews;
}

-(NSMutableDictionary*) currentNewsItemDictionary {
    if (_currentNewsItemDictionary == nil) {
        _currentNewsItemDictionary = [NSMutableDictionary new];
    }
    return _currentNewsItemDictionary;
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
    });
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        // pass dict with one news item
        if (startWritingData && self.currentNewsItemDictionary.count != 0) {
            [self.allNews addItem:[self.currentNewsItemDictionary mutableCopy]];
            [self.currentNewsItemDictionary removeAllObjects];
        }
        startWritingData = YES;
    }
    
    if ([elementName isEqualToString:@"media:thumbnail"]) {
        [self.currentNewsItemDictionary setObject:attributeDict[@"url"] forKey:@"imageURL"];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName  {
    
    if (startWritingData ) {
        if ([elementName isEqualToString:@"title"]) {
            [self.currentNewsItemDictionary setObject:currentNodeContent forKey:@"title"];
        }
        
        if ([elementName isEqualToString:@"description"]) {
            [self.currentNewsItemDictionary setObject:currentNodeContent forKey:@"newsDescription"];
        }
        
        if ([elementName isEqualToString:@"link"]) {
            [self.currentNewsItemDictionary setObject:currentNodeContent forKey:@"newsLink"];
        }
        
        if ([elementName isEqualToString:@"pubDate"]) {
            [self.currentNewsItemDictionary setObject:currentNodeContent forKey:@"pubDate"];
        }
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
