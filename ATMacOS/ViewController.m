//
//  ViewController.m
//  ATMacOS
//
//  Created by Yesoul on 2018/11/1.
//  Copyright © 2018 Yesoul. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "ZWYNetTool/ZWYNetTool.h"
#import "Model/City/ZWYCityModel.h"
#import "Model/ResCity/ZWYResModel.h"
#import "NumberTF/BRNumberField.h"
#import "JX_GCDTimer/JX_GCDTimerManager.h"

@interface ViewController ()
<
    NSTableViewDelegate,
    NSTableViewDataSource,
    NSTextFieldDelegate,
    NSSearchFieldDelegate
>

@property (weak) IBOutlet NSTableView *leftTable;
@property (weak) IBOutlet NSTableView *rightTable;
@property (weak) IBOutlet NSSearchField *searchBar;
@property (weak) IBOutlet NSTextField *startTF;
@property (weak) IBOutlet NSTextField *endTF;
@property (weak) IBOutlet BRNumberField *timeTF;
@property (weak) IBOutlet BRNumberField *priceTF;
@property (weak) IBOutlet NSButton *dateBtn;
@property (weak) IBOutlet NSButton *checkDirectBtn;
@property (weak) IBOutlet NSButton *dockBtn;


@property (nonatomic, assign) BOOL isSearching;

@property (nonatomic, strong) ZWYCityA *startCity;
@property (nonatomic, strong) ZWYCityA *endCity;
@property (nonatomic, strong) ZWYResModel *resModel;

@property (nonatomic, strong) NSMutableArray *hotCityNameArr;
@property (nonatomic, strong) NSMutableArray *cityWordArr;
@property (nonatomic, strong) NSMutableArray *cityNameArr;
@property (nonatomic, strong) NSMutableArray *searchCityWordArr;
@property (nonatomic, strong) NSMutableArray *searchCityNameArr;
@property (nonatomic, strong) NSMutableArray *resultCityArr;
@end

@implementation ViewController

- (void)dealloc {
    [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:@"tickets"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.checkDirectBtn.state = [NSUserDefaults.standardUserDefaults integerForKey:@"checkDirect"];
    
    NSClickGestureRecognizer *startTFTap = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    NSClickGestureRecognizer *endTFTap = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.startTF addGestureRecognizer:startTFTap];
    [self.endTF addGestureRecognizer:endTFTap];
    self.resultCityArr = self.resModel.cities.mutableCopy;
    [self _configTable];
    [self _getCityData];
    
    for (ZWYResCity *city in self.resultCityArr) {
        [self _getTickets:city];
    }
    
    [[JX_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:@"tickets" timeInterval:self.resModel.time.intValue > 0 ? self.resModel.time.intValue : 3600 queue:dispatch_get_main_queue() repeats:YES actionOption:AbandonPreviousAction action:^{
        for (ZWYResCity *city in self.resultCityArr) {
            [self _getTickets:city];
        }
    }];
}

- (void)_configTable {
    for (int i = 0; i < self.leftTable.tableColumns.count; i++) {
        NSTableColumn *col = self.leftTable.tableColumns[i];
        col.identifier = [NSString stringWithFormat:@"%d", i];
        if (i == 0) {
            col.width = 30;
        } else {
            col.width = 200;
        }
    }
    for (int i = 0; i < self.rightTable.tableColumns.count; i++) {
        NSTableColumn *col = self.rightTable.tableColumns[i];
        col.identifier = [NSString stringWithFormat:@"%d", i];
        if (i == 0) {
            col.width = 250;
        } else {
            col.width = 350;
        }
    }
}

- (void)_getCityData {
    [ZWYNetTool GET:@"https://zwy.dwct221.cn/ZWYDemo/tickets/cityname.php" Body:nil Header:nil Response:ZWYJSON Progress:^(id  _Nonnull progress) {
    } SuccessBlock:^(id  _Nonnull result) {
        ZWYCityModel *model = [[ZWYCityModel alloc] initWithDictionary:result[@"res"]];
        NSArray *allKeys = [model.data.cities.toDictionary.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return obj1 > obj2;
        }];
        for (NSString *key in allKeys) {
            NSArray *value = model.data.cities.toDictionary[key];
            [self.cityNameArr addObjectsFromArray:value];
            for (int i = 0; i < value.count; i++) {
                [self.cityWordArr addObject:key];
            }
        }
        self.hotCityNameArr = model.data.hots.mutableCopy;
        [self.leftTable reloadData];
    } FailureBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)_getTickets:(ZWYResCity *)city {
    NSString *url = [NSString stringWithFormat:@"https://zwy.dwct221.cn/ZWYDemo/tickets/airplane.php?dcity=%@&dcityname=%@&acity=%@&acityname=%@&date=%@", [city.dataS componentsSeparatedByString:@"|"].lastObject, city.displayS, [city.dataE componentsSeparatedByString:@"|"].lastObject, city.displayE, city.date];
    [ZWYNetTool GET:url Body:nil Header:nil Response:ZWYJSON Progress:^(id  _Nonnull progress) {
    } SuccessBlock:^(id  _Nonnull result) {
        
        if ([result[@"res"][@"data"][@"code"] intValue] > 0) {
            return;
        }
        
        if ([result[@"res"][@"status"] intValue] == 0) {
            ZWYResFlight *flight_result = [ZWYResFlight new];
            CGFloat money = CGFLOAT_MAX;
            for (NSArray *arr in result[@"res"][@"routeLists"]) {
                ZWYResFlight *flight = [ZWYResFlight new];
                NSArray *cabinsS;
                NSArray *cabinsE;
                NSMutableArray *cabinsSE = [NSMutableArray array];
                if (self.checkDirectBtn.state == NSControlStateValueOn &&
                    arr.count > 1) {
                    continue;
                }
                for (NSDictionary *dic in arr) {
                    if ([arr indexOfObject:dic] > 0) {
                        flight.airlineNameE = [NSString stringWithFormat:@"%@(%@)", dic[@"flight"][@"airlineName"], dic[@"flight"][@"flightNumber"]];
                        cabinsE = dic[@"cabins"];
                    } else {
                        cabinsS = dic[@"cabins"];
                        flight.airlineNameS = [NSString stringWithFormat:@"%@(%@)", dic[@"flight"][@"airlineName"], dic[@"flight"][@"flightNumber"]];
                    }
                }
                
                for (NSNumber *i in cabinsS) {
                    if (cabinsE) {
                        for (NSNumber *j in cabinsE) {
                            CGFloat r = i.floatValue + j.floatValue;
                            [cabinsSE addObject:@(r)];
                            if (money > r) {
                                money = r;
                            }
                        }
                    } else {
                        if (money > i.floatValue) {
                            money = i.floatValue;
                        }
                    }
                }
                
                if ([cabinsSE containsObject:@(money)]) {
                    flight_result = flight;
                } else if ([cabinsS containsObject:@(money)]) {
                    flight_result = flight;
                }
                
            }
            city.flight = flight_result;
            city.cabins = [NSString stringWithFormat:@"%.2f", money];
            [self.rightTable reloadData];
        }
        
        if (city.cabins.floatValue > 100 && city.cabins.floatValue < self.resModel.price.floatValue) {
            NSUserNotification *localNotify = [[NSUserNotification alloc] init];
            localNotify.title = [NSString stringWithFormat:@"找到便宜机票%@元", city.cabins];
            localNotify.informativeText = [NSString stringWithFormat:@"%@->%@ 时间: %@", city.displayS, city.displayE, city.date];
            localNotify.soundName = NSUserNotificationDefaultSoundName;
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:localNotify];
        }
    } FailureBlock:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    if (self.leftTable == tableView) {
        return self.isSearching ? self.searchCityNameArr.count : self.cityNameArr.count;
    }
    return self.resultCityArr.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    
    if (tableView == self.leftTable) {
        NSMutableArray *wordArr;
        NSMutableArray *cityArr;
        if (self.isSearching) {
            wordArr = self.searchCityWordArr;
            cityArr = self.searchCityNameArr;
        } else {
            wordArr = self.cityWordArr;
            cityArr = self.cityNameArr;
        }
        //获取表格列的标识符
        tableColumn.title = tableColumn.identifier.intValue == 0 ? @"标志" : @"城市";
        NSString *strIdt = @"leftTable";
        NSTableCellView *cell = [tableView makeViewWithIdentifier:strIdt owner:self];
        if (!cell) {
            cell = [[NSTableCellView alloc] init];
            cell.identifier = strIdt;
            NSTextField *textf = [NSTextField textFieldWithString:[NSString stringWithFormat:@"%@", tableColumn.identifier.intValue == 0 ? wordArr[row] : cityArr[row]]];
            textf.tag = 10086;
            [cell addSubview:textf];
        }
        NSTextField *tf = [cell viewWithTag:10086];
        tf.stringValue = [NSString stringWithFormat:@"%@", tableColumn.identifier.intValue == 0 ? wordArr[row] : cityArr[row][@"display"]];
        cell.wantsLayer = YES;
        tf.backgroundColor = NSColor.clearColor;
        tf.bordered = NO;
        tf.editable = NO;
        //自适应大小(改变label的宽度,使其刚刚好可以容纳字符)
        [tf sizeToFit];
        //调整居中位置(主要调整X方向的位置)
        tf.frame = NSMakeRect(10, 44/2-NSHeight(tf.frame)/2, NSWidth(tf.frame), NSHeight(tf.frame));
        return cell;
    }
    
    //获取表格列的标识符
    tableColumn.title = tableColumn.identifier.intValue == 0 ? @"内容" : @"价格";
    NSString *strIdt = @"rightTable";
    NSTableCellView *cell = [tableView makeViewWithIdentifier:strIdt owner:self];
    ZWYResCity *city = self.resultCityArr[row];
    if (!cell) {
        cell = [[NSTableCellView alloc] init];
        cell.identifier = strIdt;
        NSTextField *textf = [NSTextField textFieldWithString:[NSString stringWithFormat:@"%@", tableColumn.identifier.intValue == 0 ? [NSString stringWithFormat:@"%@->%@ 时间: %@", city.displayS, city.displayE, city.date] : [NSString stringWithFormat:@"价格:%@", @"1111"]]];
        textf.tag = 10086;
        [cell addSubview:textf];
        if (tableColumn.identifier.intValue == 0) {
            NSButton *button = [NSButton buttonWithTitle:@"删除" target:self action:@selector(deleteResCity:)];
            button.tag = 10010;
            [cell addSubview:button];
        }
    }
    NSTextField *tf = [cell viewWithTag:10086];
    NSButton *btn = [cell viewWithTag:10010];
    btn.frame = NSMakeRect(0, 44/2-NSHeight(btn.frame)/2, NSWidth(btn.frame), NSHeight(btn.frame));
    tf.stringValue = [NSString stringWithFormat:@"%@", tableColumn.identifier.intValue == 0 ? [NSString stringWithFormat:@"%@->%@ 时间: %@", city.displayS, city.displayE, city.date] : [NSString stringWithFormat:@"航班:%@ 价格: %@", city.flight.airlineNameE ? [NSString stringWithFormat:@"%@转%@", city.flight.airlineNameS, city.flight.airlineNameE] : city.flight.airlineNameS, city.cabins]];
    cell.wantsLayer = YES;
    tf.backgroundColor = NSColor.clearColor;
    tf.bordered = NO;
    tf.editable = NO;
    //自适应大小(改变label的宽度,使其刚刚好可以容纳字符)
    [tf sizeToFit];
    //调整居中位置(主要调整X方向的位置)
    tf.frame = NSMakeRect(NSHeight(btn.frame)+20, 44/2-NSHeight(tf.frame)/2, NSWidth(tf.frame), NSHeight(tf.frame));
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:tf.stringValue];
    [attr setAttributes:@{NSForegroundColorAttributeName: NSColor.redColor} range:[tf.stringValue rangeOfString:[NSString stringWithFormat:@"%@", city.cabins]]];
    tf.attributedStringValue = attr;
    
    return cell;
}

#pragma mark - 行高
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 44;
}

#pragma mark - 是否可以选中单元格
-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    //设置cell选中高亮颜色
    NSTableRowView *myRowView = [tableView rowViewAtRow:row makeIfNecessary:NO];
    [myRowView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];
    [myRowView setEmphasized:NO];
    return YES;
}

//选中的响应
-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification{
    
    NSTableView *tableView = notification.object;
    
    if (tableView == self.leftTable && tableView.selectedRow >= 0) {
        NSMutableArray *wordArr;
        NSMutableArray *cityArr;
        if (self.isSearching) {
            wordArr = self.searchCityWordArr;
            cityArr = self.searchCityNameArr;
        } else {
            wordArr = self.cityWordArr;
            cityArr = self.cityNameArr;
        }
        ZWYCityA *city = [[ZWYCityA alloc] initWithDictionary:cityArr[tableView.selectedRow]];
        if (self.startCity) {
            self.endCity = city;
            self.endTF.stringValue = city.display;
        } else {
            self.startCity = city;
            self.startTF.stringValue = city.display;
        }
    } else {
        if (tableView.selectedRow >= 0) {
            ZWYResCity *city = self.resultCityArr[tableView.selectedRow];
            [self _getTickets:city];
        }
    }
    [tableView deselectRow:tableView.selectedRow];
    [tableView reloadData];
}

- (void)textDidChange:(NSNotification *)notification {
    NSTextField *tf = notification.object;
    NSLog(@"%@", tf);
}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender {
    self.isSearching = NO;
    [self.leftTable reloadData];
}

- (void)deleteResCity:(NSButton *)sender {
    NSTableCellView *cell = (NSTableCellView *)sender.superview;
    NSTableView *table = (NSTableView *)cell.superview.superview;
    NSInteger row = [table rowForView:cell];
    [self.resultCityArr removeObjectAtIndex:row];
    self.resModel.cities = self.resultCityArr;
    [self.resModel save];
    [self.rightTable reloadData];
}

- (IBAction)checkDirect:(NSButton *)sender {
    [NSUserDefaults.standardUserDefaults setInteger:sender.state forKey:@"checkDirect"];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (IBAction)checkDock:(NSButton *)sender {
    if (sender.state == NSControlStateValueOn) {
        [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    } else {
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    }
    [NSUserDefaults.standardUserDefaults setInteger:sender.state forKey:@"checkDock"];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (IBAction)searchA:(NSSearchField *)sender {
    
    [self.searchCityWordArr removeAllObjects];
    [self.searchCityNameArr removeAllObjects];
    
    if (sender.stringValue.length <= 0 ||
        [sender.stringValue containsString:@" "]) {
        self.isSearching = NO;
        [self.leftTable reloadData];
        return;
    }
    
    int index = 0;
    for (NSDictionary *dic in self.cityNameArr) {
        NSString *data = dic[@"data"];
        if ([data.lowercaseString containsString:sender.stringValue]) {
            [self.searchCityNameArr addObject:dic];
            [self.searchCityWordArr addObject:self.cityWordArr[index]];
        }
        index++;
    }
    self.isSearching = YES;
    [self.leftTable reloadData];
}

- (IBAction)searchAction:(NSButton *)sender {
    ZWYResCity *city = [ZWYResCity new];
    city.date = self.dateBtn.title;
    city.dataS = self.startCity.data;
    city.dataE = self.endCity.data;
    city.displayS = self.startCity.display;
    city.displayE = self.endCity.display;
    [self.resultCityArr addObject:city];
    self.resModel.cities = self.resultCityArr;
    [self.resModel save];
    [self.rightTable reloadData];
}
- (IBAction)setTimeAction:(NSButton *)sender {
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    [alert setMessageText:@"确定设置该循环时间?"];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"确定");
            self.resModel.time = self.timeTF.stringValue;
            [self.resModel save];
            exit(0);
        } else if (returnCode == NSAlertSecondButtonReturn) {
            NSLog(@"删除");
        }
    }];
}
- (IBAction)setPriceAction:(NSButton *)sender {
    NSAlert *alert = [NSAlert new];
    [alert addButtonWithTitle:@"确定"];
    [alert addButtonWithTitle:@"取消"];
    [alert setMessageText:@"确定设置该最低价格?"];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:[self.view window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"确定");
            self.resModel.price = self.priceTF.stringValue;
            [self.resModel save];
            exit(0);
        } else if (returnCode == NSAlertSecondButtonReturn) {
            NSLog(@"删除");
        }
    }];
}
- (IBAction)selectTimeAction:(NSButton *)sender {
    [self _pickTime];
}

- (void)tapAction:(NSClickGestureRecognizer *)sender {
    NSLog(@"%@", sender.view);
    if (sender.view == self.startTF) {
        self.startCity = nil;
        self.startTF.placeholderString = @"请选择城市";
        self.startTF.stringValue = @"";
    } else {
        self.endCity = nil;
        self.endTF.placeholderString =  @"请选择城市";
        self.endTF.stringValue = @"";
    }
}

- (void)_pickTime {
    NSDatePicker *datePicker = [[NSDatePicker alloc] initWithFrame:NSMakeRect(0, 0, 500, 500)];
    [datePicker setDatePickerStyle:NSClockAndCalendarDatePickerStyle];
    // 设置日期选择控件的类型为“时钟和日历”。其他类型有如，NSTextField文本框
    [datePicker setDateValue:[NSDate date]];
    // 初始化选中当前日期
    [datePicker setAction:@selector(_updateDateResult:)];
    // 绑定每次选择日期触发的action
    [self.view addSubview:datePicker];
}
- (void)_updateDateResult:(NSDatePicker *)datePicker{
    // 拿到当前选择的日期
    NSDate *theDate = [datePicker dateValue];
    if (theDate) {
        // 把选择的日期格式化成想要的形式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateString = [formatter stringFromDate:theDate];
        NSLog(@"日期：%@",dateString);
        [self.dateBtn setTitle:dateString];
    }
    [datePicker removeFromSuperview];
}

- (NSMutableArray *)cityWordArr {
    if (!_cityWordArr) {
        _cityWordArr = [NSMutableArray array];
    }
    return _cityWordArr;
}

- (NSMutableArray *)cityNameArr {
    if (!_cityNameArr) {
        _cityNameArr = [NSMutableArray array];
    }
    return _cityNameArr;
}

- (NSMutableArray *)searchCityWordArr {
    if (!_searchCityWordArr) {
        _searchCityWordArr = [NSMutableArray array];
    }
    return _searchCityWordArr;
}

- (NSMutableArray *)searchCityNameArr {
    if (!_searchCityNameArr) {
        _searchCityNameArr = [NSMutableArray array];
    }
    return _searchCityNameArr;
}

- (NSMutableArray *)hotCityNameArr {
    if (!_hotCityNameArr) {
        _hotCityNameArr = [NSMutableArray array];
    }
    return _hotCityNameArr;
}

- (NSMutableArray *)resultCityArr {
    if (!_resultCityArr) {
        _resultCityArr = [NSMutableArray array];
    }
    return _resultCityArr;
}

- (ZWYResModel *)resModel {
    if (!_resModel) {
        _resModel = [ZWYResModel resModel];
        if (!_resModel) {
            _resModel = [ZWYResModel new];
        }
        self.priceTF.stringValue = _resModel.price ?: @"";
        self.timeTF.stringValue = _resModel.time ?: @"";
    }
    return _resModel;
}
@end
