//
//  AwfulParentForumCell.m
//  Awful
//
//  Created by me on 6/27/12.
//  Copyright (c) 2012 Regular Berry Software LLC. All rights reserved.
//

#import "AwfulParentForumCell.h"
#import "AwfulForum.h"

@implementation AwfulParentForumCell
@synthesize isExpanded = _isExpanded;

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AwfulParentForumCell"];
    if (self) {
        
    }
    return self;
}

-(void) awakeFromNib {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggle)];
    [self.imageView addGestureRecognizer:tap];
    
}

-(void) toggle {
    _isExpanded = !_isExpanded;
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:self.isExpanded]
                                                                                  forKey:@"toggle"
                              ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AwfulToggleExpandForum                                                          
                                                        object:self
                                                      userInfo:userInfo];
    //fixme: animate arrow change
    
}

-(void) setForum:(AwfulForum *)forum {
    self.textLabel.text = forum.name;
    self.textLabel.numberOfLines = 2;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.detailTextLabel.text = forum.desc;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.isExpanded = forum.expandedValue;
    self.imageView.image = [UIImage imageNamed:@"forum-arrow-right.png"];
    self.indentationLevel = 1;

}

+(CGFloat) heightForContent:(AwfulForum*)forum inTableView:(UITableView*)tableView {
    int width = tableView.frame.size.width - 20 - 55;
    
    CGSize textSize = {0, 0};
    CGSize detailSize = {0, 0};
    int height = 44;
    
    textSize = [forum.name sizeWithFont:[UIFont boldSystemFontOfSize:18]
                      constrainedToSize:CGSizeMake(width, 4000) 
                          lineBreakMode:UILineBreakModeWordWrap];
    if(forum.desc)
        detailSize = [forum.desc sizeWithFont:[UIFont systemFontOfSize:12] 
                            constrainedToSize:CGSizeMake(width, 4000) 
                                lineBreakMode:UILineBreakModeWordWrap];
    
    height = 10 + textSize.height + detailSize.height;
    
    return (MAX(height,50));
}

@end
