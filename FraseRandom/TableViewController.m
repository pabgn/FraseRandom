//
//  TableViewController.m
//  FraseRandom
//
//  Created by Pablo García-Nieto Rodríguez  on 08/08/14.
//  Copyright (c) 2014 Pablo García-Nieto Rodríguez . All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end
NSMutableArray* questions;
@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) saveData {
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dataDict setObject:questions forKey:@"questions"];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([savedData objectForKey:@"questions"] != nil) {
            questions = [[NSMutableArray alloc] initWithArray:[savedData objectForKey:@"questions"]];
            
        }
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return questions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [questions objectAtIndex:indexPath.row];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
-(void)addQuestion:(UIBarButtonItem *)sender{
    
    
   UIAlertView *questionAlert = [[UIAlertView alloc] initWithTitle:@"Nueva frase" message:@"\n\n\n"
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"Cancelar",nil) otherButtonTitles:NSLocalizedString(@"Guardar",nil), nil];
    questionAlert.tag = 2;
    questionAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [questionAlert show];

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    [questions insertObject:alertTextField.text atIndex:questions.count];
    [self saveData];
    [self.tableView reloadData];
    
    // do whatever you want to do with this UITextField.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    if(editing)
    {
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Añadir"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(addQuestion:)];
        self.navigationItem.leftBarButtonItem =  flipButton;
    }
    else
    {
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [questions removeObjectAtIndex:indexPath.row];
        [self saveData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
