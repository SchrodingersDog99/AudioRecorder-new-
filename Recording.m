//
//  Recording.m
//  AudioRecorder
//
//  Created by DonghuiLi on 16/7/6.
//  Copyright © 2016年 SchrodingersDog. All rights reserved.
//

#import "Recording.h"

@implementation Recording

@synthesize date;

-(Recording*) initWithDate:(NSDate*) aDate {
	self = [super init];
	if (self) {
		self.date = aDate;
	}
	return self;
}

-(NSString*) path {
 	NSString* home = NSHomeDirectory();
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat: @"yyyyMMddHHmmss"];
	NSString* dateString = [formatter stringFromDate: self.date];
	return [NSString stringWithFormat:@"%@/Documents/%@.caf", home, dateString];
}

-(NSURL*) url {
	NSString* pathString = self.path;
	return [NSURL fileURLWithPath: pathString];
}

-(NSString*) description {
	return [NSString stringWithFormat:@"path: %@	url: %@", self.path, [self.url absoluteString]];
}

-(Recording*) initWithCoder:(NSCoder *) decoder{
	self = [super init];
	if (self) {
		self.date = [decoder decodeObjectOfClass: [Recording class] forKey: @"date"];
	}
	return self;
}

-(void)encodeWithCoder:(NSCoder *) encoder {
	[encoder encodeObject:self.date forKey:@"date"];
}

@end
