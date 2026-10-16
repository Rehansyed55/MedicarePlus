// page 50007 "Inward Gate Entry"
// {
//     // version NAVIN5.00.01

//     Caption = 'Gate Entry - Inward';
//     PageType = Card;
//     SourceTable = Table50000;
//     SourceTableView = SORTING(Entry Type,No.)
//                       ORDER(Ascending)
//                       WHERE(Entry Type=CONST(Inward));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No.";"No.")
//                 {

//                     trigger OnAssistEdit()
//                     begin
//                         IF AssistEdit(xRec) THEN
//                           CurrPage.UPDATE;
//                         /*
//                             GateEntryLocSetup.GET("Entry Type","Location Code");
//                           GateEntryLocSetup.TESTFIELD("Posting No. Series");
//                           IF NoSeriesMgt.SelectSeries(GateEntryLocSetup."Posting No. Series","No.","No. Series") THEN
//                              NoSeriesMgt.SetSeries("No.");
//                         */

//                     end;
//                 }
//                 field("Location Code";"Location Code")
//                 {
//                 }
//                 field("Station From/To";"Station From/To")
//                 {
//                     Caption = 'Station From';
//                 }
//                 field(Description;Description)
//                 {
//                 }
//                 field("Item Description";"Item Description")
//                 {
//                 }
//                 field(Zone;Zone)
//                 {
//                 }
//                 field("Carrier/Courier";"Carrier/Courier")
//                 {
//                 }
//                 field("Supplier Code";"Supplier Code")
//                 {
//                 }
//                 field("Document Date";"Document Date")
//                 {
//                 }
//                 field("Document Time";"Document Time")
//                 {
//                 }
//                 field("Posting Date";"Posting Date")
//                 {
//                 }
//                 field("Posting Time";"Posting Time")
//                 {
//                 }
//                 field("LR/RR No.";"LR/RR No.")
//                 {
//                 }
//                 field("LR/RR Date";"LR/RR Date")
//                 {
//                 }
//                 field("Vehicle No.";"Vehicle No.")
//                 {
//                 }
//                 field("Supplier Name";"Supplier Name")
//                 {
//                 }
//             }
//             part(InwardGateEntryline;50008)
//             {
//                 SubPageLink = Entry Type=FIELD(Entry Type),
//                               Gate Entry No.=FIELD(No.);
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("P&osting ")
//             {
//                 Caption = 'P&osting ';
//                 action("P&ost")
//                 {
//                     Caption = 'P&ost';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Codeunit 50002;
//                     ShortCutKey = 'F9';
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Codeunit 50001;
//                     ShortCutKey = 'Shift+F9';
//                 }
//                 action("Goods Inward Notes")
//                 {
//                     RunObject = Report 50010;
//                 }
//             }
//         }
//     }

//     var
//         GateEntryLocSetup: Record "50002";
//         NoSeriesMgt: Codeunit "396";
// }

