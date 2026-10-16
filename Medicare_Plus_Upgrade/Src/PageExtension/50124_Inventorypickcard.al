// pageextension 50124 "Inventory pick card" extends "Inventory Pick"
// {
//     layout
//     {
//         addafter("External Document No.")
//         {
//             field("Picked By User"; Rec."Picked By User")
//             {
//                 ApplicationArea = all;
//             }
//             field("Checked By"; Rec."Checked By")
//             {
//                 ApplicationArea = all;
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