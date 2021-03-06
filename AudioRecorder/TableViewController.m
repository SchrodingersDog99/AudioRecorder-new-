//
//  TableViewController.m
//  AudioRecorder
//
//  Created by DonghuiLi on 16/7/8.
//  Copyright © 2016年 SchrodingersDog. All rights reserved.
//

#import "TableViewController.h"
#import "Recording.h"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize player;
@synthesize otherRecordingsList;



- (void) play: (Recording*) aRecording
{
	NSLog(@"%@", aRecording.url);
	NSLog(@"Playing %@", aRecording.date);
//	NSString* archive = aRecording.path;
	//if ([[NSFileManager defaultManager] isReadableFileAtPath:archive] == NO) NSLog(@"No File to read");
	//NSAssert([[NSFileManager defaultManager] fileExistsAtPath: aRecording.path], @"Doesn't exist");
	
//	NSLog(@"%@",[[NSFileManager defaultManager] contentsAtPath:archive]);
	
	NSError *error;
	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: aRecording.url error:&error];
	if(error){
		NSLog(@"playing audio: %@ %ld %@", [error domain], [error code], [[error userInfo] description]);
		return;
	}else{
		self.player.delegate = self;
	}
/*	if([self.player prepareToPlay] == NO){
		NSLog(@"Not prepared to play!");
		return;
	}
*/	NSLog(@"%@", @([self.player play]));
	
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
					   successfully:(BOOL)flag
{
	NSLog(@"done playing!!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];

	//NSLog(@"%@", @([self.otherRecordingsList count]));
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//#warning Incomplete implementation, return the number of sections
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//#warning Incomplete implementation, return the number of rows
	
	return [self.otherRecordingsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog(@"HelloWorld");
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
	
	//NSLog(@"HelloWorld");
	
	NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
	for (int i=1;i<=[self.otherRecordingsList count];i++)
		[tmpArray addObject:@(i).stringValue];
	
	// Configure the cell...
	//cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.otherRecordingsList objectAtIndex:indexPath.row]];
	//cell.textLabel.text = [tmpArray objectAtIndex:indexPath.row];
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	dateFormatter.locale = [NSLocale currentLocale];

//	NSString* recordingString = [[NSString alloc] init];
	
	Recording* r = (Recording*)[self.otherRecordingsList objectAtIndex:indexPath.row];
	
	NSString *currentDateString = [dateFormatter stringFromDate:r.date];
	//NSDate* currentDate = [dateFormatter dateFromString:currentDateString];
	//NSLog(@"%@", currentDateString);
	//cell.textLabel.text = [NSString stringWithFormat:@"%@", r.date];
	//cell.textLabel.text = [r.date descriptionWithLocale:[NSLocale currentLocale]];
	cell.textLabel.text = currentDateString;
	
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//play the audio file that maps onto the cell
	//Recording* r = [self.recordinglist objectAtIndex: indexPath.row];
	// [self play: r];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[self play: [self.otherRecordingsList objectAtIndex:indexPath.row]];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
