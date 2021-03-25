drop table dbo.RVTest

create table dbo.RVTest
(
	RVTestID int NOT NULL PRIMARY KEY,
	[Description] nvarchar(100) NOT NULL,
	CreditRating decimal(18,2) NOT NULL,
	Ver rowversion
);
GO

insert dbo.RVTest
(
	RVTestID, [Description], CreditRating
)
VALUES
(
	1, N'First value', 98
),
(
	2, N'Second value', 67.5
),
(
	3, N'Second value', 88.5
);

select * from dbo.RVTest
GO

--transaction1
--update from this transaction will change the data because in meantime transaction2 updated this row
BEGIN
-- read the data and read also row version
DECLARE @Ver rowversion;
DECLARE @CreditRating INT;
select @CreditRating = CreditRating, @Ver = Ver
from dbo.RVTest
where RVTestID = 1
SELECT @Ver AS 'Version before update';
-- next do some logic that calculates the new rating value
-- ...

WAITFOR DELAY '00:00:07'
--next update the rating but add to where clause read row version
update dbo.RVTest
set CreditRating = 123
where RVTestID = 1 and Ver = @Ver
END