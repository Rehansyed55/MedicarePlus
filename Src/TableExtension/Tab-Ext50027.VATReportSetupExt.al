tableextension 50027 "VAT Report Setup Ext" extends "VAT Report Setup"
{

    fields
    {
        modify("Modify Submitted Reports")
        {
            Caption = 'Modify Submitted Reports';
        }
    }


    // PROCEDURE GetMTDOAuthSetupCode(): Code[20]; Upgrade 25
    // BEGIN
    //     CASE "MTD OAuth Setup Option" OF
    //         "MTD OAuth Setup Option"::Production:
    //             EXIT('');
    //         //EXIT(MTDOAuth20Mgt.GetOAuthPRODSetupCode);
    //         "MTD OAuth Setup Option"::Sandbox:
    //             EXIT('');
    //         //EXIT(MTDOAuth20Mgt.GetOAuthSandboxSetupCode);
    //         ELSE
    //             EXIT('');
    //     END;
    // END;
}
