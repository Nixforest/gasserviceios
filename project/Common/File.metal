//
//  File.metal
//  project
//
//  Created by SPJ on 5/1/17.
//  Copyright © 2017 admin. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
// Version: 1.53.0
// - Sửa lỗi giao diện ở màn hình đơn hàng hộ gia đình.
// - Sửa lỗi cập nhật số lượng của màn hình yêu cầu vật tư, giúp việc cập nhật số lượng dễ dàng hơn.
// - Sửa lỗi phần cập nhật số nhà của KH Hộ gia đình.
// - Thêm biến platform khi login.
// Version: 1.52.0
// - Thêm field action_invest, thêm radio button chọn action_invest trong tạo và cập nhật yêu cầu vật tư
// - Chuyển cách chọn vât tư cũ sang chọn theo tag module, khi chọn hiển thị pop up với list vật tư, có thể chọn được nhiều vật tư
// Version: 1.51.0
// - Fix lỗi ở list vâtj tư ở đơn hàng HGĐ
// Version: 1.50.0
// - Đơn hàng hộ GĐ thêm phần up hình + chụp hình giống các form cũ + redesign
// - Gasservice - Change param page = 0 when request CCS Code and Add Button Done for Address Picker View
// - Gasservice - Gasservice - Design New Create Ticket View, Hide Handler Picker when role Customer, allow push Image 
// - Family order list: First show current date. Add Search function
// - Change [Basemodel._userInfo] from optional to normal variable
// - Khuất giao diện ở iPhone 4s
// Version: 1.49.0
// - Gasservice - Set Family Order title and Vip Customer Order title bigger
// Version: 1.48.0
// - Gasservice - Add Configbean store_keeper for Home screen (Stock keeper)
// - Gasservice - Stock List
// - Gasservice - Stock View/Update
// - Add field gas_remain_car and gas remain_driver in Api Update Config
// - Gasservice - Stock Real View
// - Gasservice - Stock Real Update
// - Gasservice - Fix keyboard problem
// - Gasservice - Delete Button Sum, add Cylinder info and Sum in tab cylinder of Vip Customer Order View
// Version: 1.47.0
// - Gasservice - Customer Request List
// - Gasservice - Customer Request View
// - Gasservice - Customer Request Create
// Version: 1.40.0
// - BUG0190: Add user report field - Report CCS
// Version: 1.33.0
// - BUG0155: Change loading view to random
// - BUG0154: Add image in VIP order detail when update
// Version: 1.32.0
// - BUG0153: Fix bug create Cashbook schedule
// Version: 1.31.0
// - Fix bug [The network connection was lost]
// Version: 1.30.0
// - BUG0152: Fix bug when create store card - Still remain Material in list
// - BUG0151: Handle favourite when select material
// - BUG0150: VIP customer order of Driver - Update list order UI
// - BUG0148: Change icon of Ticket closed status
// - BUG0146: Handle error: request to server create log
// - BUG0145: VIP customer order list - Change status icon position
// Version: 1.29.0
// - BUG0149: Handle show Gas remain and Sum all cylinder in Customer VIP order
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

