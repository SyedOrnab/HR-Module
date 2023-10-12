# HR-Module
## Leave Application

**Fields**:
- **Employee No.** - Code[20], Table Reference = Employee (Primary Key)
- **Entry No.** - Integer (Primary Key)
- **From Date** - (Validation)
- **To Date** - (Validation) [From Date must not be the same as To Date] && [From Date must be earlier than To Date]
- **Leave Type** - Code[10]
- **Description** - Text[100]
- **Leave Quantity** - Decimal
- **Leave Remaining** - Integer
- **Unit of Measure Code** - Code [10], Table Reference = "Human Resource Unit of Measure”. Code
- **Comment** - Boolean

**Features**:
- **Entry No.** - Auto-Generated
- **Date Validation**
- **Leave Quantity** = To Date – From Date
- Action to "Calculate Leave Remaining" calculates total absence data and updates the Leave Remaining field. (Leave remaining calculation data is obtained from Employee Absence for individual employees)
- Leave remaining cannot be negative. If Leave Remaining is less than zero, it is displayed as zero.
- **Comment** - Boolean

