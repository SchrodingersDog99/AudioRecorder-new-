//
//  TableViewController.h
//  AudioRecorder
//
//  Created by DonghuiLi on 16/7/8.
//  Copyright © 2016年 SchrodingersDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TableViewController : UITableViewController  <AVAudioPlayerDelegate> 

@property (strong, nonatomic) NSMutableArray* otherRecordingsList;
@property (strong, nonatomic) AVAudioPlayer* player;

@end
