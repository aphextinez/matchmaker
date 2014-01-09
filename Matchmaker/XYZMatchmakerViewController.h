//
//  XYZMatchmakerViewController.h
//  Matchmaker
//
//  Created by Chelsea Updike on 12/3/13.
//  Copyright (c) 2013 Atallah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZMatchmakerViewController : UIViewController <NSStreamDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
    
    //UITableView *tView;
    //UIView *matchView;
    //NSMutableArray * messages;
    
    NSInputStream           *inputStream;
	NSOutputStream          *outputStream;
	
    UITextField             *inputEmail;
    UITextField             *inputPassword;
    
    UITextField             *q1;
    UITextField             *q2;
	UITextField             *q3;
	UITextField             *q4;
	UITextField             *q5;
    
    UITextField             *inputNameField;
    UITextField             *inputAgeField;
	UITextField             *inputEmailField;
	UITextField             *inputPasswordField;
	UITextField             *inputVerifyField;
	UISegmentedControl		*inputGenderField;
    
    UILabel *matchesText;
    
    IBOutlet UILabel *yourLabel;
    
    BOOL ready;
    //NSString *output;

}

//@property (retain, nonatomic) IBOutlet UITableView *tView;
//@property (retain, nonatomic) IBOutlet UIView *matchView;
//@property (nonatomic, retain) NSMutableArray *messages;

@property (retain, nonatomic) IBOutlet UILabel *matchesText;

@property (nonatomic, retain) IBOutlet UITextField *inputNameField;
@property (nonatomic, retain) IBOutlet UITextField *inputAgeField;
@property (nonatomic, retain) IBOutlet UITextField *inputEmailField;
@property (nonatomic, retain) IBOutlet UITextField *inputPasswordField;
@property (nonatomic, retain) IBOutlet UITextField *inputVerifyField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *inputGenderField;

@property (nonatomic, retain) IBOutlet UITextField *q1;
@property (nonatomic, retain) IBOutlet UITextField *q2;
@property (nonatomic, retain) IBOutlet UITextField *q3;
@property (nonatomic, retain) IBOutlet UITextField *q4;
@property (nonatomic, retain) IBOutlet UITextField *q5;
@property BOOL ready;
@property NSString *output;
@property (nonatomic, retain) IBOutlet UITextField *inputEmail;
@property (nonatomic, retain) IBOutlet UITextField *inputPassword;
@property (retain, nonatomic) IBOutlet UILabel *yourLabel;



@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

- (IBAction)login;
- (IBAction)submitAnswers;
- (IBAction)createLogin;
- (IBAction)showMatches;

@end