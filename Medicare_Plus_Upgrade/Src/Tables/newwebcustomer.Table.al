table 50016 "new web customer"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; NavCustomerNo; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(3; RegisteredCompanyName; Text[50])
        {
            Caption = 'Name';
        }
        field(4; ApplicantAddress; Text[100])
        {
            Caption = 'Address';
        }
        field(5; ApplicantAddress2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(6; City; Text[30])
        {
        }
        field(7; ApplicantTelephoneNo1; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(8; ApplicantTelephoneNo2; Text[30])
        {
            Caption = 'Phone No.2';
        }
        field(9; ApplicationFaxNo1; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(10; ApplicantEmail; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(11; VatNo; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(15; County; Text[30])
        {
        }
        field(16; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(17; "Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(18; "Primary Contact No."; Code[20])
        {
            TableRelation = Contact;
        }
        field(20; Blocked; Option)
        {
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(21; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(22; ModifiedDate; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(23; Password; Text[20])
        {
        }
        field(24; CustomerStatus; Option)
        {
            Caption = 'Customer Status';
            Editable = false;
            OptionCaption = 'New Customer,Existing Customer';
            OptionMembers = "New Customer","Existing Customer";
        }
        field(25; CustomerProfileStatus; Option)
        {
            Caption = 'Customer Profile Status';
            OptionCaption = 'Created,Modified,Updated';
            OptionMembers = Created,Modified,Updated;
        }
        field(26; ApplicationFaxNo2; Text[30])
        {
            Caption = 'Application Fax No 2';
        }
        field(27; BankAccountNo; Code[20])
        {
            Caption = 'Bank Account No.';
        }
        field(28; BankAddress; Text[250])
        {
            Caption = 'Bank Address';
        }
        field(29; BankFaxNo; Text[20])
        {
            Caption = 'Bank Fax No.';
        }
        field(30; BankName; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(31; BankSortCode; Code[20])
        {
            Caption = 'Bank Sort Code';
        }
        field(32; BankTelephoneNo; Text[30])
        {
            Caption = 'Bank Telephone No';
        }
        field(33; BankYears; Text[20])
        {
            Caption = 'Bank Years';
        }
        field(34; BusinessAccountContactDept; Text[50])
        {
            Caption = 'Business Account Contact Dept';
        }
        field(35; Businessaddress; Text[100])
        {
            Caption = 'Business Address';
        }
        field(36; BusinessCompanyType; Text[50])
        {
            Caption = 'Business Company Type';
        }
        field(37; BusinessEmail; Text[80])
        {
            Caption = 'Business Email';
        }
        field(38; BusinessEmail2; Text[80])
        {
            Caption = 'Business Email 2';
        }
        field(39; BusinessFaxNo; Text[30])
        {
            Caption = 'Business Fax No';
        }
        field(40; BusinessFaxNo2; Text[30])
        {
            Caption = 'Business Fax No 2';
        }
        field(41; BusinessFullNamesDirectors; Text[100])
        {
            Caption = 'Business Full Names Directors';
        }
        field(42; BusinessMobileNo2; Text[30])
        {
            Caption = 'Business Mobile No 2';
        }
        field(43; BusinessFullNamesShareHolders; Text[30])
        {
            Caption = 'Business Full Names Share Holders';
        }
        field(44; BusinessTelephoneNo2; Text[30])
        {
            Caption = 'Business Telephone No 2';
        }
        field(45; BusinessType; Text[250])
        {
            Caption = 'Business Type';
        }
        field(46; BussinessAccountContactPos; Text[50])
        {
            Caption = 'Bussiness Account Contact Pos.';
        }
        field(47; BussinessMobileNO; Text[20])
        {
            Caption = 'Bussiness Mobile No.';
        }
        field(48; BussinessTelephoneNo1; Text[30])
        {
            Caption = 'Bussiness Telephone No 1';
        }
        field(49; CompanyRegistrationNo; Code[20])
        {
            Caption = 'Company Registration No';
        }
        field(50; CompleteformName; Text[50])
        {
            Caption = 'Complete form Name';
        }
        field(51; CompleteformPosition; Text[50])
        {
            Caption = 'Complete form Position';
        }
        field(52; CreditMonthlyCredit; Text[50])
        {
            Caption = 'Credit Monthly Credit';
        }
        field(53; DeliveryAddress; Text[100])
        {
            Caption = 'Delivery Address';
        }
        field(54; NoofBranches; Code[20])
        {
            Caption = 'No of Branches';
        }
        field(55; Noofyears; Integer)
        {
            Caption = 'No of years';
        }
        field(56; RDBTradingAnticipation; Text[50])
        {
            Caption = 'RDB Trading Anticipation';
        }
        field(57; RDBWholesaleDealerLicense; Text[50])
        {
            Caption = 'RDB Wholesale Dealer License';
        }
        field(58; ReferenceAddress1; Text[100])
        {
            Caption = 'Reference Address1';
        }
        field(59; ReferenceAddress2; Text[100])
        {
            Caption = 'Reference Address2';
        }
        field(60; ReferenceEmail1; Text[80])
        {
            Caption = 'Reference Email1';
        }
        field(61; ReferenceEmail2; Text[80])
        {
            Caption = 'Reference Email 2';
        }
        field(62; ReferenceFaxNo1; Text[30])
        {
            Caption = 'Reference Fax No 1';
        }
        field(63; ReferenceFaxNo2; Text[30])
        {
            Caption = 'Reference Fax No 2';
        }
        field(64; ReferenceName1; Text[50])
        {
            Caption = 'Reference Name 1';
        }
        field(65; ReferenceName2; Text[50])
        {
            Caption = 'Reference Name 2';
        }
        field(66; ReferenceTelephoneNo1; Text[30])
        {
            Caption = 'Reference Telephone No1';
        }
        field(67; ReferenceTelephoneNo2; Text[30])
        {
            Caption = 'Reference Telephone No 2';
        }
        field(69; Repname; Text[30])
        {
            Caption = 'Rep Name';
        }
        field(70; TradingName; Text[100])
        {
            Caption = 'Trading Name';
        }
        field(71; WholesaleLicenseNo; Text[50])
        {
            Caption = 'Wholesale License No.';
        }
        field(72; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
        }
        field(73; DeliveryAddress2; Text[50])
        {
            Caption = 'Delivery Address 2';
        }
        field(74; Businessaddress2; Text[50])
        {
            Caption = 'Business Address 2';
        }
        field(75; ReferenceAddress12; Text[50])
        {
            Caption = 'Reference Address 12';
        }
        field(76; ReferenceAddress22; Text[50])
        {
            Caption = 'Reference Address 22';
        }
        field(77; BankAddress2; Text[50])
        {
            Caption = 'Bank Address 2';
        }
        field(78; DeliveryCountry; Code[10])
        {
        }
        field(79; DeliveryCounty; Text[30])
        {
        }
        field(80; DeliveryPostcode; Code[20])
        {
        }
        field(81; DeliveryCity; Text[30])
        {
        }
        field(82; ReferenceCity12; Text[30])
        {
        }
        field(83; ReferencePostCode12; Code[20])
        {
        }
        field(84; ReferenceCountryCode1; Code[10])
        {
        }
        field(85; ReferenceCity22; Text[30])
        {
        }
        field(86; ReferencePostCode22; Code[20])
        {
        }
        field(87; ReferenceCountryCode2; Code[10])
        {
        }
        field(88; "Web status"; Option)
        {
            OptionCaption = 'Not Approved,Approved';
            OptionMembers = "Not Approved",Approved;
        }
        field(89; BusinessCounty; Text[30])
        {
        }
        field(90; BusinessCity; Text[30])
        {
        }
        field(91; BusinessPostCode; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

