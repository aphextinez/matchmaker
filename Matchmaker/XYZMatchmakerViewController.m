//
//  XYZMatchmakerViewController.m
//  Matchmaker
//
//  Created by Chelsea Updike on 12/3/13.
//  Copyright (c) 2013 Atallah. All rights reserved.
//

#import "XYZMatchmakerViewController.h"

@implementation XYZMatchmakerViewController

//@synthesize tView, matchView, messages;
@synthesize q1, q2, q3, q4, q5;
@synthesize inputStream, outputStream;
@synthesize yourLabel;
@synthesize ready;
@synthesize inputEmail, inputPassword;
@synthesize inputNameField, inputAgeField, inputEmailField, inputPasswordField, inputVerifyField;
@synthesize inputGenderField;
//@synthesize output;
@synthesize matchesText;

NSString *output = @"";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNetworkCommunication];
    
    if (ready == 1){
    //self.yourLabel = [[UILabel alloc ] initWithFrame:CGRectMake((self.view.bounds.size.width / 2), 0.0, 150.0, 43.0)];
    [yourLabel setTextColor:[UIColor blackColor]];
    
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    
    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    
    //[yourLabel setText:output];
    
        NSLog(@"in here and output is %@", output);
    
    self.yourLabel.text = output;
    
   //[self.view addSubview:self.yourLabel];
        
        [yourLabel setText:output];
        
        
        
    }
	
//    messages = [[NSMutableArray alloc] init];
    
    
//	self.tView.delegate = self;
//	self.tView.dataSource = self;
    
    
	// Do any additional setup after loading the view.
}

- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"10.0.1.3", 5555, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}

/*

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *s = (NSString *) [messages objectAtIndex:indexPath.row];
	
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = s;
	return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return messages.count;
}
                
- (void) messageReceived:(NSString *)message {
                    
        [self.messages addObject:message];
        [self.tView reloadData];
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:messages.count-1
                                                                   inSection:0];
        [self.tView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionMiddle
                                              animated:YES];
    
}
*/

- (IBAction)login {
    
    
    NSString *response  = [NSString stringWithFormat:@"Login:%@ %@",self.inputEmail.text, self.inputPassword.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
  //  [self.view bringSubviewToFront:matchView];
    
}

- (IBAction)submitAnswers {
    
    
    NSString *response  = [NSString stringWithFormat:@"Form:%@ %@ %@ %@ %@", self.q1.text, self.q2.text, self.q3.text, self.q4.text, self.q5.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    //[self.view bringSubviewToFront:matchView];
}

- (IBAction)createLogin {
    
    
    NSString *response  = [NSString stringWithFormat:@"createLogin:%@ %@ %@ %@ %@ %ld", self.inputNameField.text, self.inputAgeField.text, self.inputEmailField.text, self.inputPasswordField.text, self.inputVerifyField.text, (long)self.inputGenderField.selectedSegmentIndex];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    //NSLog(@"stream event %i", streamEvent);
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
			//NSLog(@"Stream opened");
			break;
            
		case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output1 = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                      //  output = [[NSString alloc] init];
                        
                        if (nil != output1) {
                            //ready = YES;
                            output = [output1 copy];
                           NSLog(@"server said: %@ and ready is %hhd", output , ready);
                           
                           
                            /*
                            [yourLabel setTextColor:[UIColor blackColor]];
                            
                            [yourLabel setBackgroundColor:[UIColor clearColor]];
                            
                            [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
                            
                            [yourLabel setText:output1];
                            
                            NSLog(@"in here and output is %@", output);
                            
                            //self.yourLabel.text = theText;
                            
                            [self.view addSubview:self.yourLabel];
                            [yourLabel setNeedsDisplay];
                             */
                            
                            
      //                      [self messageReceived:output];
                        }
                    }
                }
            }
			break;
            
        case NSStreamEventHasSpaceAvailable:
            //NSLog(@"HERE!");
            break;
            
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
			break;
            
		case NSStreamEventEndEncountered:
            NSLog(@"Event end!");
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
			break;
            
		default:
			NSLog(@"Unknown event");
	}
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMatches {
    NSLog(@"output is %@", output);
    self.yourLabel.text = output;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
