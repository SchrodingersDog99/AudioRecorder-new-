//
//  ViewController.h
//  AudioRecorder
//
//  Created by DonghuiLi on 16/7/6.
//  Copyright © 2016年 SchrodingersDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recording.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController <AVAudioRecorderDelegate, AVAudioSessionDelegate>


@property (strong, nonatomic) NSMutableArray* recordingsList;
@property (strong, nonatomic) Recording* currentRecording;
@property (strong, nonatomic) AVAudioRecorder* recorder;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) NSTimer* timer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)startRecording:(id)sender;
- (IBAction)stopRecording:(id)sender;
- (void)handleTimer;

@end

