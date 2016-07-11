//
//  Recording.h
//  AudioRecorder
//
//  Created by DonghuiLi on 16/7/6.
//  Copyright © 2016年 SchrodingersDog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recording : NSObject <NSCoding>
@property (strong, nonatomic) NSDate* date;
@property (readonly, nonatomic) NSString* path;
@property (readonly, nonatomic) NSURL* url;
@property (strong, nonatomic) NSString* name;

-(Recording*) initWithDate:(NSDate*) aDate;

@end
