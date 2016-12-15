//
//  ImageDownloader.h
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject

+ (id)sharedObject;


-(void) fetchImageWithUrl:(NSURL*) imgageUrl andCallBack:( void (^)(NSData* imageData)) completion;

@end
