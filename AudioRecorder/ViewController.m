//
//  ViewController.m
//  AudioRecorder
//
//  Created by DonghuiLi on 16/7/6.
//  Copyright © 2016年 SchrodingersDog. All rights reserved.
//

#import "ViewController.h"
#import "Recording.h"
#import "TableViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()

@end

@implementation ViewController
@synthesize recordingsList;
@synthesize currentRecording;
@synthesize recorder;
@synthesize timer;
static bool isRecording = NO;


- (void)viewDidLoad {
	[super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (ViewController*) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		NSString* archive = [NSString stringWithFormat:@"%@/Documents/RecordingArchive", NSHomeDirectory()];
		if ([[NSFileManager defaultManager] fileExistsAtPath:archive]) {
			self.recordingsList = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
		}
		else {
			self.recordingsList = [[NSMutableArray alloc] init];
		}
	}
	if (self.recordingsList == nil) self.recordingsList = [[NSMutableArray alloc] init];
	
	
	//NSLog(@"%@", recordingsList);
	return self;
}

- (void) viewWillDisappear:(BOOL)animated {
	NSString* archive = [NSString stringWithFormat:@"%@/Documents/RecordingArchive", NSHomeDirectory()];
	[NSKeyedArchiver archiveRootObject:recordingsList toFile:archive];
}

- (void)handleTimer {
	float x = self.progressView.progress;
	//NSLog(@"%f", x);
	//if ((@(0.96)).floatValue == x)
	self.progressView.progress += 0.04;
	self.timerLabel.text = [NSString stringWithFormat:@"%0.1f",  self.progressView.progress * 5] ;
	
	x = self.progressView.progress;
	if (x - 1 >= (-0.0001) && x - 1 <= 0.0001) {
		//NSLog(@"HelloWorld");
		self.timerLabel.text = @"0";
		[self.timer invalidate];
		[self.progressView setProgress:0];
		self.currentRecording = nil;
		[self.recorder stop];
		self.statusLabel.text = @"Hi!";
		isRecording = NO;
	}
}

- (IBAction)startRecording:(id)sender {
	if (isRecording == NO) {
		isRecording = YES;
//	if (0.3 == 0.3) NSLog(@"0.3 == 0.3");
//	float x = 0.3;
//	if ((@(0.3)).floatValue == x) NSLog(@"x == 0.3");
	AVAudioSession* audioSession = [AVAudioSession sharedInstance];
	NSError* err = nil;
	[audioSession setCategory:AVAudioSessionCategoryRecord error:&err];
	if (err) {
		NSLog(@"audioSession: %@ %ld %@", [err domain], [err code], [[err userInfo] description]);
		return;
	}
	err = nil;
	
	[audioSession setActive:YES error:&err];
	if (err) {} //**
	
	self.currentRecording = [[Recording alloc] initWithDate: [NSDate date]];
	[self.recordingsList addObject: self.currentRecording];
	
	//NSLog(@"%@", self.currentRecording);
	
	err = nil;
	
	NSMutableDictionary* recordingSettings = [[NSMutableDictionary alloc] init];
	[recordingSettings setValue:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
	[recordingSettings setValue:@44100.0 forKey:AVSampleRateKey];
	[recordingSettings setValue:@1 forKey:AVNumberOfChannelsKey];
	[recordingSettings setValue:@16 forKey:AVLinearPCMBitDepthKey];
	[recordingSettings setValue:@(NO) forKey:AVLinearPCMIsBigEndianKey];
	[recordingSettings setValue:@(NO) forKey:AVLinearPCMIsFloatKey];
	[recordingSettings setValue:@(AVAudioQualityHigh)
						 forKey:AVEncoderAudioQualityKey];

	
	self.recorder = [[AVAudioRecorder alloc]
	    initWithURL:self.currentRecording.url
		   settings:recordingSettings
			  error:&err];
	
	if (!self.recorder) {
		NSLog(@"recorder: %@ %ld %@", [err domain], [err code], [[err userInfo] description]);
		return;
	}
	
	[self.recorder setDelegate:(id)self];   ///!!!!!!!!
	[self.recorder prepareToRecord];
	self.recorder.meteringEnabled = YES;
	BOOL audioHWAvailable = audioSession.inputAvailable;
	if (!audioHWAvailable) {return;} // **
	
	[recorder recordForDuration:(NSTimeInterval)5];
	
	self.statusLabel.text = @"Recording...";
	self.progressView.progress = 0.0;
	self.timer = [NSTimer
				  scheduledTimerWithTimeInterval:0.2
							target:self
	  			  selector:@selector(handleTimer)
						  userInfo:nil
						   repeats:YES];
	}
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	TableViewController* tvc = (TableViewController*) segue.destinationViewController;
	tvc.otherRecordingsList = self.recordingsList;
}

- (IBAction)stopRecording:(id)sender {
	self.timerLabel.text = @"0";
	[self.progressView setProgress:0];
	[timer invalidate];
	self.currentRecording = nil;
	[self.recorder stop];
	self.statusLabel.text = @"Hi!";
	isRecording = NO;
}
@end
