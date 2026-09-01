tableextension 50044 "Posted Invt. Pick Line Ext" extends "Posted Invt. Pick Line"
{
    fields
    {
        field(50000; Barcode; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50006; "Scan Time"; Time)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50007; "Barcode 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50008; Checked; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50009; "Checked By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50010; "Box Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50011; "No. of Box"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50012; "Pallet Number"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50013; "Total Unit/Box"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50014; "Units Sub Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }
        field(50015; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '//Upgradation Nav13';
        }

        field(50100; "Process Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
         field(50106; "Picked By User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
