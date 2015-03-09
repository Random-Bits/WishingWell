//
//  RBWWUserProfileTableViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 5/03/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWUserProfileTableViewController.h"
#import "RBWWImageFileView.h"

@interface RBWWUserProfileTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet RBWWImageFileView *profilePhoto;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

-(void)updateUI;

@end

@implementation RBWWUserProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateUI
{
    self.navigationItem.rightBarButtonItem.enabled = self.editing && [self.profile isValidForUpdate];
    if (self.profile.firstName) {
        self.firstNameTextField.text = self.profile.firstName;
    }
    if (self.profile.lastName) {
        self.lastNameTextField.text = self.profile.lastName;
    }
    //self.profilePhoto.image = [self.profile getThumbnail];
    [self.profilePhoto setFile:self.profile.thumbnail];
}



#pragma mark - TableView Delegate
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Only allow selection if editing.
    if (self.editing) {
        return indexPath;
    }
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        __weak RBWWUserProfileTableViewController  *weakSelf = self;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            [alert addAction:[UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.delegate = weakSelf;
                [weakSelf presentViewController:imagePickerController animated:YES completion:nil];        }]];
        }
        [alert addAction:[UIAlertAction actionWithTitle:@"Choose existing photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.delegate = weakSelf;
            [weakSelf presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        switch (indexPath.row) {
            case 0:
                [self.firstNameTextField becomeFirstResponder];
                break;
            case 1:
                [self.lastNameTextField becomeFirstResponder];
                break;
            default:
                break;
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    if ([[segue identifier] isEqualToString:@"Save Profile"]) {
        self.profile.firstName = self.firstNameTextField.text;
        self.profile.lastName = self.lastNameTextField.text;
    }

}

#pragma mark - Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *selectedPhoto = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.profilePhoto.image = selectedPhoto;
    [self.delegate profileEditor:self didSetPhoto:selectedPhoto];
    [self.profile setProfileImageWithData:UIImagePNGRepresentation(selectedPhoto)];
    //Or you can get the image url from AssetsLibrary
   
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    //[self updateUI];
}

@end
