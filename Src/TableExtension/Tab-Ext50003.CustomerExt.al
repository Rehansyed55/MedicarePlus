tableextension 50003 "Customer Ext" extends Customer
{
    fields
    {
        field(50001; "Cost Amount(Actual)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Source Type" = FILTER(Customer),
                                                                          "Source No." = FIELD("No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Description = '//Upgradation Nav13';

        }
        field(50002; "Sales Amount(Actual)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Source Type" = FILTER(Customer),
                                                                           "Source No." = FIELD("No."),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Description = '//Upgradation Nav13';
        }
        field(50003; "Customer Type"; Option)
        {
            Description = 'CAS-04125-V3M1R5';
            OptionCaption = ' ,Wholesaler,Retail Pharmacy,Fragrance';
            OptionMembers = " ",Wholesaler,"Retail Pharmacy",Fragrance;
        }
        field(50004; "WDL No"; Code[30])
        {
            Description = 'CAS-04125-V3M1R5';
        }
        field(50005; "Created Date"; Date)
        {
            Description = 'CAS-04125-V3M1R5';
        }
        field(50006; "Created By"; Code[50])
        {
            Description = 'CAS-04125-V3M1R5';
        }
        field(50007; "GPHC No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'BC Upgrade';
        }
        field(50008; "WDA Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "CD Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "CD No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Customer lic. Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pharmasist,Wholesaler;
        }
    }

    trigger OnInsert()
    var
    begin
        "Created Date" := WORKDATE;
        "Created By" := USERID;

        //CAS-04125-V3M1R5
    end;
}
