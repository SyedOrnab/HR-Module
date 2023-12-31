report 50004 "Employee Information Report"
{
    ApplicationArea = All;
    Caption = 'Employee Information';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Employee Information Report/Report/Employee Info.rdlc';
    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.");
            column(No; 'No.')
            {
            }
            column(First_Name; "First Name")
            {
            }

            column(Middle_Name; "Middle Name")
            {
            }

            column(Last_Name; "Last Name")
            {
            }

            column(Initials; Initials)
            {
            }

            column(Job_Title; "Job Title")
            {
            }

            column(Search_Name; "Search Name")
            {
            }

            column(Address; Address)
            {
            }

            column(Address_2; "Address 2")
            {
            }

            column(City; City)
            {
            }

            column(Post_Code; "Post Code")
            {
            }

            column(County; County)
            {
            }

            column(Phone_No_; "Phone No.")
            {
            }

            column(Mobile_Phone_No_; "Mobile Phone No.")
            {
            }

            column(E_Mail; "E-Mail")
            {
            }

            column(Alt__Address_Code; "Alt. Address Code")
            {
            }

            column(Alt__Address_Start_Date; "Alt. Address Start Date")
            {
            }

            column(Alt__Address_End_Date; "Alt. Address End Date")
            {
            }

            /*column(Picture; Picture)
            {
            }*/

            column(Birth_Date; "Birth Date")
            {
            }

            column(Social_Security_No_; "Social Security No.")
            {
            }

            column(Union_Code; "Union Code")
            {
            }

            column(Union_Membership_No_; "Union Membership No.")
            {
            }

            column(Gender; Gender)
            {
            }

            column(Country_Region_Code; "Country/Region Code")
            {
            }

            column(Manager_No_; "Manager No.")
            {
            }

            column(Emplymt__Contract_Code; "Emplymt. Contract Code")
            {
            }

            column(Statistics_Group_Code; "Statistics Group Code")
            {
            }

            column(Employment_Date; "Employment Date")
            {
            }

            column(Status; Status)
            {
            }

            column(Inactive_Date; "Inactive Date")
            {
            }

            column(Cause_of_Inactivity_Code; "Cause of Inactivity Code")
            {
            }

            column(Termination_Date; "Termination Date")
            {
            }

            column(Grounds_for_Term__Code; "Grounds for Term. Code")
            {
            }

            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }

            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }

            column(Resource_No_; "Resource No.")
            {
            }

            column(Comment; Comment)
            {
            }

            column(Last_Date_Modified; "Last Date Modified")
            {
            }

            column(Date_Filter; "Date Filter")
            {
            }

            column(Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }

            column(Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }

            column(Cause_of_Absence_Filter; "Cause of Absence Filter")
            {
            }

            column(Total_Absence__Base_; "Total Absence (Base)")
            {
            }

            column(Extension; Extension)
            {
            }

            column(Employee_No__Filter; "Employee No. Filter")
            {
            }

            column(Pager; Pager)
            {
            }

            column(Fax_No_; "Fax No.")
            {
            }
            column(Company_E_Mail; "Company E-Mail")
            {
            }

            column(Title; Title)
            {
            }

            column(Salespers__Purch__Code; "Salespers./Purch. Code")
            {
            }

            column(No__Series; "No. Series")
            {
            }

            column(Last_Modified_Date_Time; "Last Modified Date Time")
            {
            }

            column(Employee_Posting_Group; "Employee Posting Group")
            {
            }

            column(Bank_Branch_No_; "Bank Branch No.")
            {
            }

            column(Bank_Account_No_; "Bank Account No.")
            {
            }

            column(IBAN; IBAN)
            {
            }

            column(Balance; Balance)
            {
            }

            column(SWIFT_Code; "SWIFT Code")
            {
            }

            column(Application_Method; "Application Method")
            {
            }

            column(Image; Image)
            {
            }
            
            column(Time_Sheet_Approver_User_ID; "Time Sheet Approver User ID")
            {
            }
            dataitem("Employee Qualification"; "Employee Qualification")
            {
                DataItemLink = "Employee No." = field("No.");
                column(Employee_No_; "Employee No.")
                {
                }
                column(Qualification_Code; "Qualification Code")
                {
                }
                column(From_Date; "From Date")
                {
                }
                column(To_Date; "To Date")
                {
                }
                column(Description; "Description")
                {
                }
                column(Type; Type)
                {
                }
                column(Institution_Company; "Institution/Company")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
