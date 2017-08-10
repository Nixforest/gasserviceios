//
//  File.metal
//  project
//
//  Created by SPJ on 5/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
// Version: 1.29.0
// - BUG0139: VIP Order - Add new Discount field
// Version: 1.28.0
// - BUG0138: Handle loading view process
// - BUG0137: Change Payback money text
// - BUG0131: Hide Navigator when loading
// - BUG0129: Update all icons
// - BUG0128: Update right border of Order detail screen
// Version: 1.27.0
// - BUG0137: Handle Payback money for VIP Order
// - BUG0136: Handle sum all cylinders
// - BUG0135: Add new cylinder, clear all cylinders in Order VIP customer
// - BUG0134: Change pass screen: Add logout button
// Version: 1.26.0
// - BUG0133: Family order: change agent delivery
// - BUG0132: Remember username after login
// - BUG0130: Remove Signout menu
// - BUG0127: Uphold rating - merge to 1 step
// - BUG0047: Refactor BaseRequest class
// Version: 1.25.0
// - BUG0126: Handle input quantity of material when create VIP Customer order
// - BUG0125: Handle input quantity of material when edit Family Customer Order
// - BUG0124: Add button Add new in VIP Customer order list, VIP Customer uphold list
// - BUG0123: Handle update Agent id after change on Account screen
// - BUG0122: Handle back to previous after finish send handle in StepVC screen
// - BUG0121: Handle show icon on Home screen for NVGN
// Version: 1.24.0
// - BUG0120: Show username in Account screen
// - BUG0119: G07F00S02: Handle update customer in Order Family
// Version: 1.23.0
// - BUG0118: Make Ticket always show on order
// - BUG0117: G07F00S02: Can Add/Change/Delete Gas Family Order
// - BUG0116: Handle VIP customer order: select sub-agent
// - BUG0066: Show full code label in VIP Order list
// Version: 1.22.0
// - BUG0115: Handle add version code when request server
// - BUG0114: Handle show note in Order Family and Order VIP
// Version: 1.21.0
// - BUG0113: G05F00S04VC: Bug when input "," inside number field
// - BUG0112: Create load screen
// - BUG0111: G06 - CCS code for G07F00S02VC
// - BUG0049: Handle notification for Order family, Ticket and SPJ code comeback
// Version: 1.20.0
// - BUG0111: G06 - CCS code
// - BUG0110: G03 - Add new function
// - BUG0008: G00_Account update
// Version: 1.19.0
// - BUG0109: HarpyFramework: Fix bug UI StepVC
// - BUG0078: Fix bug reload table view make data overlapping
// Version: 1.18.0
// - BUG0107: Handle image in store card
// Version: 1.17.0
// - BUG0104: Update function G05
// - BUG0103: Update function G07
// Version: 1.16.0
// - BUG0102: Add new function G11
// Version: 1.15.0
// - BUG0101: Fix bug change value of from date and to date in Report screens
// - BUG0100: Update func G01: add Family Uphold sub-function
// Version: 1.14.0
// - BUG0099: Fix bug when Logout failed
// - BUG0098: Add new function G10
// - BUG0086: Change place holder on field phone number in Order VIP create screen
// Version: 1.13.0
// - BUG0086: Add phone number to Order VIP create screen
// Version: 1.12.2
// - BUG0097: Add sub-function G09 - Schedule cashbook
// - BUG0096: Add image when create Cashbook (G09)
// - BUG0095: Fix bug show human icon in VIP order
// - BUG0094: Add function create order by Coordinator
// - BUG0093: Add new function G09
// - BUG0092: Handle error when request API -> Show message
// - BUG0090: Show confirm alert when back from create screen
// - BUG0063: Fix bug in Create order (By customer) screen
// Version: 1.11.0
// - BUG0079: Add order type and support type in Family order
// - BUG0080: Check if new password is equal with old password in Change Password screen
// - BUG0081: UITableView not reload until scroll
// - BUG0082: Change BaseRequest handle completion mechanism (OrderFamilyListRequest)
// - BUG0083: Add Cylinder in VIP Order bug
// - BUG0084: Show "Show password" checkbox on Login screen
// - BUG0085: Change label of Action button on Order Family detail screen
// - BUG0087: Remove message Logout success
// - BUG0088: Can change gas material in Order Family detail screen
// - BUG0089: Fix bug move up view when focus text view
// Version: 1.10.0
// - BUG0073: Add new function G08
// - BUG0078: Fix bug reload table view make data overlapping
// - BUG0077: Need change password
// Version: 1.9.0
// - BUG0063: Descrease corner radius of Note textfield in Order Vip screen
// - BUG0073: Add new function G08
// - BUG0074: Change icon Gas Service on Map screen to Gas 24h

