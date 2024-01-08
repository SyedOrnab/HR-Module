tableextension 50100 "Ext Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "Requisition Nos"; Code[10])
        {
            Caption = 'Requisition Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50101; "Requisition Workflow"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group";
        }
        field(50102; "PRC Workflow"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Workflow User Group";
        }
        field(50103; "Expense Nos"; Code[10])
        {
            Caption = 'Expense Nos';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}