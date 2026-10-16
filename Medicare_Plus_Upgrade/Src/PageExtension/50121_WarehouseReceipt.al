// pageextension 50121 "Warehouse Receipt ext" extends "Warehouse Receipt"
// {
//     layout
//     {
//         addafter("Bin Code")
//         {
//             field(" Select All"; Rec." Select All")
//             {
//                 ApplicationArea = all;

//                 trigger OnValidate()
//                 var
//                     warehousereceiptline: Record "Warehouse Receipt Line";
//                 begin
//                     warehousereceiptline.RESET; //chem-493
//                     warehousereceiptline.SETRANGE(warehousereceiptline."No.", Rec."No."); //chem-493
//                     IF warehousereceiptline.FIND('-') THEN //chem-493
//                         REPEAT
//                             warehousereceiptline."Create Production Order" := Rec." Select All";
//                             warehousereceiptline.MODIFY;
//                         UNTIL warehousereceiptline.NEXT = 0;
//                 end;
//             }
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }