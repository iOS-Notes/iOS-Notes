//
//  ViewController.m
//  DragAndDropDemo
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 DragAndDropDemo. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCellModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource,
UITableViewDragDelegate, UITableViewDropDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TableViewCellModel *model1 = [[TableViewCellModel alloc] initWithTitleString:@"Name 1"];
    TableViewCellModel *model2 = [[TableViewCellModel alloc] initWithTitleString:@"Name 2"];
    TableViewCellModel *model3 = [[TableViewCellModel alloc] initWithTitleString:@"Name 3"];
    TableViewCellModel *model4 = [[TableViewCellModel alloc] initWithTitleString:@"Name 4"];
    TableViewCellModel *model5 = [[TableViewCellModel alloc] initWithTitleString:@"Name 5"];
    TableViewCellModel *model6 = [[TableViewCellModel alloc] initWithTitleString:@"Name 6"];
    TableViewCellModel *model7 = [[TableViewCellModel alloc] initWithTitleString:@"Name 7"];
    
    [self.dataSource addObjectsFromArray:@[model1, model2, model3, model4, model5, model6, model7]];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"UITableViewCell"];
    }
    TableViewCellModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"IndexPath: %@", model.titleString];
    
    return cell;
}

#pragma mark - Table View Drag Delegate
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView
        itemsForBeginningDragSession:(id<UIDragSession>)session
                         atIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCellModel *model = self.dataSource[indexPath.row];
    
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:model];
    
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[dragItem];
}

#pragma mark - Table View Drop Delegate
- (void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator {
    
    if (!coordinator) {
        return;
    }
    
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    [tableView performBatchUpdates:^{
        
        [coordinator.items enumerateObjectsUsingBlock:^(id<UITableViewDropItem>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (!obj) {
                return;
            }
            
            NSIndexPath *indexPath = obj.sourceIndexPath;
            
            TableViewCellModel *model = self.dataSource[indexPath.row];
            
            [self.dataSource removeObject:model];
            [self.dataSource insertObject:model
                                  atIndex:destinationIndexPath.row];
            
            [tableView moveRowAtIndexPath:indexPath
                              toIndexPath:destinationIndexPath];
        }];
        
    } completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canHandleDropSession:(id<UIDropSession>)session {
    return [session canLoadObjectsOfClass:TableViewCellModel.class];
}

- (UITableViewDropProposal *)tableView:(UITableView *)tableView
                  dropSessionDidUpdate:(id<UIDropSession>)session
              withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath {
    return [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UITableViewDropIntentInsertAtDestinationIndexPath];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
        _tableView.dragDelegate = self;
        _tableView.dropDelegate = self;
        _tableView.dragInteractionEnabled = YES;
    }
    return _tableView;
}

@end
