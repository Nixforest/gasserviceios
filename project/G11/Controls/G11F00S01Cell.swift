//
//  G11F00S01Cell.swift
//  project
//
//  Created by SPJ on 6/4/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import harpyframework

class G11F00S01Cell: UITableViewCell {
    // MARK: Properties
    private var topView:    UIView = UIView()
    private var leftView:   UIView = UIView()
    private var centerView: UIView = UIView()
    private var rightView:  UIView = UIView()
    
    // Top control
    private var titleLabel: UILabel = UILabel()
    
    // Left controls
    private var dateTime: CustomeDateTimeView = CustomeDateTimeView()
    private var topHeight: CGFloat = GlobalConst.LABEL_H
    
    // Center controls
    private var codeLabel:      UILabel     = UILabel()
    private var commentIcon:    UIImageView = UIImageView()
    private var commentLabel:   UILabel     = UILabel()
    // Right control
    private var statusIcon: UIImageView = UIImageView()
    public static var CELL_HEIGHT: CGFloat = 0.0
    
    // MARK: Methods
    /**
     * Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Initialization code
        let contentHeight       = GlobalConst.CELL_HEIGHT_SHOW / 3 * 2
        let contentWidthLeft    = GlobalConst.SCREEN_WIDTH / 4
        let contentWidthMid     = GlobalConst.SCREEN_WIDTH / 2
        let contentWidthRight   = GlobalConst.SCREEN_WIDTH / 4
        let verticalMargin      = GlobalConst.MARGIN_CELL_X * 2
        var offset: CGFloat     = 0.0
        /** ---- Left view ------ */
        self.dateTime.setup(x: 0, y: 0, w: contentWidthLeft, h: contentHeight)
        offset += self.dateTime.frame.height
        G11F00S01Cell.CELL_HEIGHT = topHeight + contentHeight
        self.topView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: topHeight)
        self.leftView.frame = CGRect(x: 0,
                                     y: topView.frame.maxY,
                                     width: contentWidthLeft,
                                     height: offset)
        self.centerView.frame = CGRect(x: self.leftView.frame.maxX,
                                       y: topView.frame.maxY,
                                       width: contentWidthMid,
                                       height: offset)
        self.rightView.frame = CGRect(x: self.centerView.frame.maxX,
                                      y: 0,
                                      width: contentWidthRight,
                                      height: G11F00S01Cell.CELL_HEIGHT)
        /** ----- Top view ----- */
        // Customer label
        self.titleLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X, y: GlobalConst.MARGIN_CELL_X,
                                          width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                          height: topHeight)
        self.titleLabel.font = UIFont.systemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.titleLabel.textColor = GlobalConst.MAIN_COLOR
        self.titleLabel.text = DomainConst.BLANK
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode = .byWordWrapping
        
        /** ---- Center view ------ */
        offset = verticalMargin
        // Code label
        self.codeLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                      y: offset,
                                      width: contentWidthMid + contentWidthRight,//- GlobalConst.MARGIN_CELL_X,
                                      height: contentHeight / 3)
        self.codeLabel.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.codeLabel.text = DomainConst.BLANK
        offset += self.codeLabel.frame.height + GlobalConst.MARGIN_CELL_Y
        
        // Comment icon
        self.commentIcon.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                        y: offset,
                                        width: GlobalConst.CELL_HEIGHT_SHOW / 5,
                                        height: GlobalConst.CELL_HEIGHT_SHOW / 5)
        self.commentIcon.contentMode = .scaleAspectFit
        self.commentIcon.image = ImageManager.getImage(named: DomainConst.HUMAN_ICON_IMG_NAME)
        // Total label
        self.commentLabel.frame = CGRect(x: self.commentIcon.frame.maxX,
                                         y: offset,
                                         width: contentWidthMid + contentWidthRight,
                                         height: self.commentIcon.frame.height)
        self.commentLabel.font = UIFont.boldSystemFont(ofSize: GlobalConst.NORMAL_FONT_SIZE)
        self.commentLabel.textColor = GlobalConst.TEXT_COLOR_GRAY
        self.commentLabel.text = DomainConst.BLANK
        offset += self.commentIcon.frame.height + GlobalConst.MARGIN_CELL_Y
        
        /** ---- Right view ------ */
        // Status icon
        self.statusIcon.frame = CGRect(x: (contentWidthRight - contentHeight / 3) / 2,
                                       y: (rightView.frame.height - GlobalConst.ICON_SIZE) / 2,
                                       width: GlobalConst.ICON_SIZE,
                                       height: GlobalConst.ICON_SIZE)
        self.statusIcon.image = ImageManager.getImage(named: DomainConst.BLANK)
        
        self.topView.addSubview(self.titleLabel)
        self.leftView.addSubview(dateTime)
        self.centerView.addSubview(self.codeLabel)
        self.rightView.addSubview(self.statusIcon)
        self.centerView.addSubview(self.commentIcon)
        self.centerView.addSubview(self.commentLabel)
        self.addSubview(self.topView)
        self.addSubview(self.leftView)
        self.addSubview(self.centerView)
        self.addSubview(self.rightView)
        self.makeComponentsColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /**
     * Set data for cell
     * - parameter data: TicketBean object
     * - parameter isClosed: Flag check if this model is Closed ticket, default is false
     */
    //++ BUG0148-SPJ (NguyenPT 20170817) Change icon of Ticket closed status
    //open func setData(data: TicketBean) {
    open func setData(data: TicketBean, isClosed: Bool = false) {
    //-- BUG0148-SPJ (NguyenPT 20170817) Change icon of Ticket closed status
        if data.time_reply.isBlank {
            self.dateTime.setValue(dateTime: data.created_date)
            self.commentLabel.text = data.name_user_to
        } else {
            self.dateTime.setValue(dateTime: data.time_reply)
            self.commentLabel.text = data.name_user_reply
        }
        self.titleLabel.text = data.title.capitalizingFirstLetter()
        self.codeLabel.text = data.name
        self.statusIcon.image = ImageManager.getImage(named: getStatusIcon(isReplied: !data.time_reply.isBlank))
        //++ BUG0148-SPJ (NguyenPT 20170817) Change icon of Ticket closed status
        if isClosed {
            self.statusIcon.image = ImageManager.getImage(named: DomainConst.FINISH_STATUS_IMG_NAME)
        }
        //-- BUG0148-SPJ (NguyenPT 20170817) Change icon of Ticket closed status
        updateLayouts(topH: GlobalConst.LABEL_H)
    }
    
    /**
     * Get status icon from status string
     * - parameter isReplied: Flag is replied
     * - returns: Status icon path
     */
    private func getStatusIcon(isReplied: Bool) -> String {
        var retVal = DomainConst.BLANK
        if isReplied {
            retVal = DomainConst.COMMENT_IMG_NAME
        } else {
            retVal = DomainConst.ORDER_STATUS_NEW_ICON_IMG_NAME
        }
        return retVal
    }
    
    
    /**
     * Set data for cell
     * - parameter data: TicketReplyBean object
     */
    open func setData(dataReply: TicketReplyBean) {
        self.dateTime.setValue(dateTime: dataReply.created_date)
        self.commentLabel.text = dataReply.position
        let title = dataReply.content.capitalizingFirstLetter()
        self.titleLabel.text = title
        self.codeLabel.text = dataReply.name
        let topH = title.heightWithConstrainedWidth(width: GlobalConst.SCREEN_WIDTH,
                                                         font: self.titleLabel.font)
        updateLayouts(topH: topH)
    }
    
    /**
     * Upd
     */
    private func updateLayouts(topH: CGFloat) {
        topHeight = topH
        let contentWidthLeft    = GlobalConst.SCREEN_WIDTH / 4
        let contentWidthMid     = GlobalConst.SCREEN_WIDTH / 2
        let contentWidthRight   = GlobalConst.SCREEN_WIDTH / 4
        let offset = self.dateTime.frame.height
        let contentHeight       = GlobalConst.CELL_HEIGHT_SHOW / 3 * 2
        G11F00S01Cell.CELL_HEIGHT = topHeight + contentHeight
        self.topView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: GlobalConst.SCREEN_WIDTH,
                                    height: topHeight)
        self.leftView.frame = CGRect(x: 0,
                                     y: topView.frame.maxY,
                                     width: contentWidthLeft,
                                     height: offset)
        self.centerView.frame = CGRect(x: self.leftView.frame.maxX,
                                       y: topView.frame.maxY,
                                       width: contentWidthMid,
                                       height: offset)
        self.rightView.frame = CGRect(x: self.centerView.frame.maxX,
                                      y: 0,
                                      width: contentWidthRight,
                                      height: G11F00S01Cell.CELL_HEIGHT)
        self.titleLabel.frame = CGRect(x: GlobalConst.MARGIN_CELL_X,
                                       y: GlobalConst.MARGIN_CELL_X,
                                       width: GlobalConst.SCREEN_WIDTH - 2 * GlobalConst.MARGIN_CELL_X,
                                       height: topHeight)
    }
}
