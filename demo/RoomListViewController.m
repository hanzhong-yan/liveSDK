//
//  RoomListViewController.m
//  kxmovie
//
//  Created by hanzhong.yan on 16/5/17.
//
//

#import "RoomListViewController.h"
#import "TableViewCell.h"
#import "IJKMoviePlayerViewController.h"



@interface RoomListViewController ()
@property NSMutableArray *roomList;
@property int  isLocal ;
@end

@implementation RoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLocal = 0;
    //[self getRoomListFromServer];
    if(self.roomList == nil){
        [self initRoomListData];
        self.isLocal = 1 ;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//从服务器获取直播列表
-(void) getRoomListFromServer {
    NSString *strUrl = [[NSString alloc] initWithFormat:@"http://172.30.21.143:7001/shatalive/liveList?action=%@",@"query"];
    NSLog(@"请求开始%@",@"192的地址");
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSError *error ;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSLog(@"%@",error);
    if(data != nil){
        NSLog(@"请求完成%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"请求完成%@",dict);
        self.roomList = [dict objectForKey:@"list"];
    }
}

-(void) initRoomListData {
    if(self.roomList == nil){
        self.roomList = [[NSMutableArray alloc] init];
    }
    NSDictionary *room = [[NSDictionary alloc] initWithObjectsAndKeys:@"pic2.jpg", @"image",@"沙塔直播",@"title" , @"沙塔cdn网络性能演示",@"desc",@"rtmp://live.hkstv.hk.lxdns.com/live/hks",@"streamAddr", nil];
    [self.roomList addObject:room];
//    NSDictionary *room1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"image1.jpg", @"avatar",@"label1",@"title" , @"label2",@"desc", nil];
//    [self.roomList addObject:room1];
//    NSDictionary *room2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"image1.jpg", @"avatar",@"label1",@"title" , @"label2",@"desc", nil];
//    [self.roomList addObject:room2];
//    NSDictionary *room3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"image1.jpg", @"avatar",@"label1",@"title" , @"label2",@"desc", nil];
//    [self.roomList addObject:room3];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"==================================");
    return [self.roomList count];  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
    }
    NSDictionary *room = [self.roomList objectAtIndex:indexPath.row];
    cell.label1.text = [room objectForKey:@"title"];
    cell.label2.text = [room objectForKey:@"desc"];
//    cell.image.image = [UIImage imageNamed:[room objectForKey:@"avatar"]];
    UIImage *image ;
    if(self.isLocal == 1){
        image = [UIImage imageNamed:[room objectForKey:@"image"] inBundle:nil compatibleWithTraitCollection:nil];
    }else{
        NSURL *url = [NSURL URLWithString: [room objectForKey:@"image"]];
        image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    }
   
    cell.image.image = image;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *path;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    path =  @"rtsp://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov";
    path = [[[self roomList] objectAtIndex:indexPath.row] objectForKey:@"streamAddr"];
    //path = @"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8";
    NSString *transitImgUrl ;
    transitImgUrl = [[[self roomList] objectAtIndex:indexPath.row] objectForKey:@"image"];
    NSString *suffix ;
    suffix = [transitImgUrl substringFromIndex:[transitImgUrl rangeOfString:@"." options:NSBackwardsSearch].location];
    transitImgUrl = [transitImgUrl stringByReplacingOccurrencesOfString:suffix withString:[@"_transit" stringByAppendingString:suffix]];
    [parameters setObject:transitImgUrl forKey:@"transitImgUrl"];
    
    
    UIImage *image ;
    if(self.isLocal == 1){
        image = [UIImage imageNamed:transitImgUrl inBundle:nil compatibleWithTraitCollection:nil];
    }else{
        NSURL *url = [NSURL URLWithString: transitImgUrl];
        image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    }
    UIImageView *transmitImgView = [[UIImageView alloc] initWithImage:image];
    [parameters setObject:transmitImgView forKey:@"transmitImgView"];
    
    NSURL *url = [NSURL URLWithString:path];
    [IJKVideoViewController presentFromViewController:self withTitle:[NSString stringWithFormat:@"URL: %@", path] URL:url parameters:parameters completion:^{
        //            [self.navigationController popViewControllerAnimated:NO];
    }];
    //[self.navigationController pushViewController:secondVC animated:YES];
    //[self presentViewController:secondVC animated:YES completion:nil];
}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL) shouldAutorotate {
    return NO;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
